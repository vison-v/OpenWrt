#!/usr/bin/env bash
#
# Copyright (C) 2022 Ing <https://github.com/wjz304>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/vison-v/OpenWrt
# File name: custom.sh
# Description: OpenWrt custom script
#

repo=${1:-lede}
owner=${2:-ViS0N}

echo "OpenWrt custom script"

echo "repo: ${repo}; owner: ${owner};"

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Modify banner
if [ "${owner}" = "ViS0N" ]; then
  if [ "${repo}" = "openwrt" ]; then
    cat >package/base-files/files/etc/banner <<EOF
  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__|               Openwrt Build By ${owner} 
 -----------------------------------------------------
 %D %V, %C
 -----------------------------------------------------

EOF
  else
    cat >package/base-files/files/etc/banner <<EOF
     _________
    /        /\      _    ___ ___  ___
   /  LE    /  \    | |  | __|   \| __|
  /    DE  /    \   | |__| _|| |) | _|
 /________/  LE  \  |____|___|___/|___| Lede Build By ${owner}  
 \        \   DE /
  \    LE  \    /  -------------------------------------------
   \  DE    \  /    %D %V, %C
    \________\/    -------------------------------------------

EOF
  fi
else
  cat >package/base-files/files/etc/banner <<EOF
 ██████╗ ██████╗ ███████╗███╗   ██╗██╗    ██╗██████╗ ████████╗
██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║    ██║██╔══██╗╚══██╔══╝
██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║ █╗ ██║██████╔╝   ██║   
██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║███╗██║██╔══██╗   ██║   
╚██████╔╝██║     ███████╗██║ ╚████║╚███╔███╔╝██║  ██║   ██║   
 ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝   
  -------------------------------------------
  		%D %V, %C      Build By ${owner} 
  -------------------------------------------
EOF
fi

defaultsettings=*/*/default-settings
[ "${repo}" = "openwrt" ] && language=zh_cn || language=zh_Hans

# Modify the version number
sed -i "s/OpenWrt /${owner} build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" ${defaultsettings}/files/zzz-default-settings
sed -i "s/LEDE /${owner} build $(TZ=UTC-8 date "+%Y.%m.%d") @ LEDE /g" ${defaultsettings}/files/zzz-default-settings

# Modify maximum connections
[ "${repo}" = "openwrt" ] && sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Modify default theme
deftheme=bootstrap
if [ "${owner}" = "ViS0N" ]; then
  deftheme=argon
else
  deftheme=bootstrap
fi
echo deftheme: ${deftheme}
sed -i "s/bootstrap/${deftheme}/g" feeds/luci/collections/luci/Makefile
sed -i "s/bootstrap/${deftheme}/g" feeds/luci/modules/luci-base/root/etc/config/luci

# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
  echo 'CONFIG_KERNEL_BUILD_USER="${owner}"' >>.config ||
  sed -i "s|\(CONFIG_KERNEL_BUILD_USER=\).*|\1$\"${owner}\"|" .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
  echo 'CONFIG_KERNEL_BUILD_DOMAIN="${owner}"' >>.config ||
  sed -i 's|\(CONFIG_KERNEL_BUILD_DOMAIN=\).*|\1$"${owner}"|' .config

# Modify app list
sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab
[ "${repo}" = "lede" ] && sed -i '19,34d' package/lean/default-settings/files/zzz-default-settings
sed -i '/msgid "Hostnames"/{n;s/主机名/主机映射/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
#sed -i 's/LEDE /LEDE Build By ViS0N /' package/lean/default-settings/files/zzz-default-settings
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-diag-core/po/zh_Hans/diag_core.po
sed -i 's/%D %V, %C/%D %V, %C, Build By ViS0N/g' package/base-files/files/etc/banner
curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/88/89/g' feeds/luci/applications/luci-app-autoreboot/luasrc/controller/autoreboot.lua
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/luci/applications/luci-app-socat/po/zh_Hans/socat.po
sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua
sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/msgstr "备份与升级"/msgstr "备份\/升级"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/msgstr "DHCP\/DNS"/msgstr "DHCP服务"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/KMS 服务器/KMS 服务/g' feeds/luci/applications/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po
sed -i 's/msgstr "MultiWAN 管理器"/msgstr "负载均衡"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po
sed -i 's/msgstr "软件包"/msgstr "软件管理"/g' feeds/luci/applications/luci-app-opkg/po/zh_Hans/opkg.po
sed -i 's/msgstr "软件包"/msgstr "软件管理"/g' feeds/luci/applications/luci-app-package-manager/po/zh_Hans/package-manager.po

sed -i "s/'miniDLNA Settings'/'DLNA设置'/" feeds/luci/applications/luci-app-minidlna/htdocs/luci-static/resources/view/minidlna.js
sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po
echo -e "\nmsgid \"miniDLNA Settings\"" >> feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po
echo -e "msgstr \"DLNA设置\"" >> feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po

sed -i 's/msgstr "IP\/MAC绑定"/msgstr "地址绑定"/g' feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po
echo -e "\nmsgid \"Rules\"" >> feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po
echo -e "msgstr \"规则\"" >> feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po

sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/luci/applications/luci-app-cifs-mount/po/zh_Hans/cifs.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po
sed -i 's/admin\/services\/nlbw/admin\/nlbw/g' feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json

sed -i 's/msgstr "ZeroTier"/msgstr "内网穿透"/g' feeds/luci/applications/luci-app-zerotier/po/zh_Hans/zerotier.po
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json

sed -i 's/上网时间控制/时间控制/g' feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po
sed -i 's/services/control/g'  `grep services -rl feeds/luci/applications/luci-app-accesscontrol/luasrc`


sed -i 's/解除网易云音乐播放限制/网易音乐/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
###--------------------------------------------------------------------------------------------------------###
sed -i 's/services/vpn/g'  `grep services -rl feeds/vi/luci-app-pushbot/luasrc`
sed -i 's/Tcpdump 流量监控/流量截取/g' feeds/vi/luci-app-tcpdump/po/zh_Hans/tcpdump.po
sed -i 's/services/control/g'  `grep services -rl feeds/vi/OpenAppFilter/luci-app-oaf/luasrc`
sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/vi/luci-app-argon-config/po/zh_Hans/argon-config.po
#sed -i 's/TTYD 终端/命令终端/g' feeds/vi/luci-app-ttyd/po/zh_Hans/terminal.po
sed -i 's/services/vpn/g'  feeds/vi/luci-app-wechatpush/root/usr/share/luci/menu.d/luci-app-wechatpush.json
sed -i 's/"control"/"services"/g'  `grep control -rl feeds/vi/luci-app-control-timewol/luasrc`
sed -i 's/msgstr "流量监控"/msgstr "实时流量"/g' feeds/vi/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po

sed -i '/msgid "Pass Wall"/{n;s/PassWall/翻越长城/;}' feeds/vi/small/luci-app-passwall/po/zh_Hans/passwall.po
sed -i '/Pass Wall/s/-1/4/g' feeds/vi/small/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/vi/small/luci-app-passwall/luasrc`

sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' feeds/vi/luci-app-smartdns/po/zh_Hans/smartdns.po
sed -i 's/services/vpn/g' feeds/vi/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

sed -i 's/services/system/g' feeds/vi/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i 's/msgstr "Watchcat"/msgstr "智能重启"/g' feeds/vi/luci-app-watchcat/po/zh_Hans/watchcat.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' feeds/vi/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/vi/luci-app-unblockmusic/luasrc`
