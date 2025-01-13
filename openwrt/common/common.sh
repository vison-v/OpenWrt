#!/bin/bash 
##############加载自定义app################

curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/I.base >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt Build By ViS0N '" >> package/base-files/files/etc/openwrt_release

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/%D %V, %C/%D %V, %C, Build By ViS0N/g' package/base-files/files/etc/banner

sed -i 's/msgstr "DHCP\/DNS"/msgstr "DHCP服务"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/msgstr "主机名映射"/msgstr "主机映射"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/msgstr "备份与升级"/msgstr "备份升级"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/"重启"/"立即重启"/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "VPN"/{n;s/VPN/酷软/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po

sed -i 's/msgstr "MultiWAN 管理器"/msgstr "多播管理"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po
sed -i 's/msgstr "UPnP IGD 和 PCP"/msgstr "UPnP服务"/g' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
sed -i 's/msgstr "ACME 证书"/msgstr "ACME证书"/g' feeds/luci/applications/luci-app-acme/po/zh_Hans/acme.po
sed -i 's/msgstr "软件包"/msgstr "软件管理"/g' feeds/luci/applications/luci-app-package-manager/po/zh_Hans/package-manager.po
sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua

#sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
#sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
#sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
#sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po
#sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
#sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
sed -i "s/'miniDLNA Settings'/'DLNA设置'/" feeds/luci/applications/luci-app-minidlna/htdocs/luci-static/resources/view/minidlna.js
sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po
echo -e "\nmsgid \"miniDLNA Settings\"" >> feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po
echo -e "msgstr \"DLNA设置\"" >> feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i '/"title": "Terminal",/a\		"order": 47,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/msgstr "终端"/msgstr "命令终端"/g' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po
sed -i 's/admin\/services\/nlbw/admin\/nlbw/g' feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json

sed -i 's/services/system/g'  feeds/luci/applications/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i 's/msgstr "Watchcat"/msgstr "智能重启"/g' feeds/luci/applications/luci-app-watchcat/po/zh_Hans/watchcat.po
##---------------------------------------------------------------------------------------------------------##
sed -i 's/msgstr "Tcpdump 流量监控"/msgstr "流量监控"/g' feeds/vi/luci-app-tcpdump/po/zh_Hans/tcpdump.po
sed -i 's/KMS 服务器/KMS 服务/g' feeds/vi/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po
sed -i 's/services/vpn/g'  feeds/vi/luci-app-wechatpush/root/usr/share/luci/menu.d/luci-app-wechatpush.json
sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/vi/luci-app-argon-config/po/zh_Hans/argon-config.po
sed -i 's/services/control/g'  `grep services -rl feeds/vi/luci-app-appfilter/luasrc`
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/vi/luci-app-socat/po/zh_Hans/socat.po
sed -i '/msgid "ZeroTier"/{n;s/msgstr "ZeroTier"/msgstr "内网穿透"/;}' feeds/vi/luci-app-zerotier/po/zh_Hans/zerotier.po

sed -i 's/解除网易云音乐播放限制/网易音乐/g' feeds/vi/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
sed -i 's/services/vpn/g' feeds/vi/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json

sed -i 's/nas/services/g' feeds/vi/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/vi/luci-app-cifs-mount/po/zh_Hans/cifs.po

sed -i '/msgid "Pass Wall"/{n;s/PassWall/翻越长城/;}' feeds/vi/luci-app-passwall/po/zh_Hans/passwall.po
sed -i '/Pass Wall/s/-1/4/g' feeds/vi/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/vi/luci-app-passwall/luasrc`

sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' feeds/vi/luci-app-smartdns/po/zh_Hans/smartdns.po
sed -i 's/services/vpn/g'  feeds/vi/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

##############自定义结束#################
echo "等我想想"
