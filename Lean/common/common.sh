#!/bin/bash 

rm -Rf feeds/packages/net/{smartdns,aria2,adguardhome,wrtbwmon} feeds/packages/lang/golang feeds/luci/themes/luci-theme-argon feeds/luci/applications/{luci-app-eqos,luci-app-netdata,luci-app-baidupcs-web,luci-app-dockerman,luci-app-wrtbwmon,luci-app-watchcat,luci-app-ttyd,luci-app-unblockmusic,luci-app-pushbot}
##############定义函数################
function git_clone() {
          git clone --depth 1 $1 $2
          if [ "$?" != 0 ]; then
            echo "error on $1"
            pid="$( ps -q $$ )"
            kill $pid
          fi
        }
function git_sparse_clone() {
        trap 'rm -rf "$tmpdir"' EXIT
        branch="$1" curl="$2" && shift 2
        rootdir="$PWD"
        tmpdir="$(mktemp -d)" || exit 1
        if [ ${#branch} -lt 10 ]; then
        git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
        cd "$tmpdir"
        else
        git clone --filter=blob:none --sparse "$curl" "$tmpdir"
        cd "$tmpdir"
        git checkout $branch
        fi
        if [ "$?" != 0 ]; then
            echo "error on $curl"
            exit 1
        fi
        git sparse-checkout init --cone
        git sparse-checkout set "$@"
        mv -n $@ $rootdir/ || true
        cd $rootdir
        }
function mvdir() {
        mv -n `find $1/* -maxdepth 0 -type d` ./
        rm -rf $1
        }
##############加载自定义app################
mkdir package/openwrt-packages
##--------------------------##
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter

git clone https://github.com/tty228/luci-app-wechatpush.git package/openwrt-packages/luci-app-wechatpush

git clone https://github.com/kenzok8/small.git package/openwrt-packages/small
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

git clone https://github.com/jerrykuku/luci-app-argon-config.git package/openwrt-packages/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git package/openwrt-packages/luci-theme-argon

#git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump

#git clone https://github.com/pymumu/luci-app-smartdns -b lede package/openwrt-packages/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git package/openwrt-packages/smartdns

git_sparse_clone main "https://github.com/kiddin9/kwrt-packages.git" luci-app-eqos wrtbwmon luci-app-wrtbwmon luci-app-watchcat luci-app-ttyd luci-app-unblockmusic luci-app-pushbot luci-app-smartdns luci-app-tcpdump && mv -n wrtbwmon package/openwrt-packages/
git_sparse_clone main "https://github.com/kiddin9/luci.git" applications/luci-app-ttyd

git_clone https://github.com/Lienol/openwrt-package.git && mv -n openwrt-package/{luci-app-control-timewol,luci-app-control-webrestriction,luci-app-control-weburl} package/openwrt-packages/; rm -rf openwrt-package
##--------------------------##
mv luci-* package/openwrt-packages/
##############菜单整理美化#################

./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab
sed -i '19,32d' package/lean/default-settings/files/zzz-default-settings
sed -i '/msgid "Hostnames"/{n;s/主机名/主机映射/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/OpenWrt /OpenWrt Build By ViS0N /' package/lean/default-settings/files/zzz-default-settings
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-diag-core/po/zh_Hans/diag_core.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po
sed -i 's/%D %V, %C/%D %V, %C, Build By ViS0N/g' package/base-files/files/etc/banner
curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/88/89/g' feeds/luci/applications/luci-app-autoreboot/luasrc/controller/autoreboot.lua
sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/luci/applications/luci-app-socat/po/zh_Hans/socat.po
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/luci/applications/luci-app-cifs-mount/po/zh_Hans/cifs.po
#sed -i 's/msgstr "实时流量监测"/msgstr "流量"/g' feeds/luci/applications/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua
sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/KMS 服务器/KMS 服务/g' feeds/luci/applications/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po
sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po
sed -i 's/msgstr "IP/MAC绑定"/msgstr "地址绑定"/g' feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po
sed -i 's/msgstr "MultiWAN 管理器"/msgstr "负载均衡"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

sed -i '/localtime  = os.date()/s/()/("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i '/local cpu_usage/a\\t\tlocal up_time = luci.sys.exec("cntime")' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i "s/String.format('%t', info.uptime)/info.uptime/" package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i 's/= sysinfo.uptime or 0/= up_time/' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i '/$(INSTALL_DIR) $(1)\/sbin/a\\t$(INSTALL_BIN) .\/files\/generic\/cntime $(1)\/sbin\/cntime' package/lean/autocore/Makefile

sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po

sed -i 's/带宽监控/监控/g' package/emortal/default-settings/i18n/more.zh_Hans.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po
sed -i 's/admin\/services\/nlbw/admin\/nlbw/g' feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json

sed -i 's/msgstr "ZeroTier"/msgstr "内网穿透"/g' feeds/luci/applications/luci-app-zerotier/po/zh_Hans/zerotier.po
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json

sed -i 's/上网时间控制/时间控制/g' feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po
sed -i 's/services/control/g'  `grep services -rl feeds/luci/applications/luci-app-accesscontrol/luasrc`


sed -i 's/解除网易云音乐播放限制/网易音乐/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
###--------------------------------------------------------------------------------------------------------###
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-pushbot/luasrc`
sed -i 's/Tcpdump 流量监控/流量截取/g' package/openwrt-packages/luci-app-tcpdump/po/zh_Hans/tcpdump.po
sed -i 's/services/control/g'  `grep network -rl package/openwrt-packages/OpenAppFilter/luci-app-oaf/luasrc`
sed -i 's/"Argon 主题设置"/"主题设置"/g' package/openwrt-packages/luci-app-argon-config/po/zh_Hans/argon-config.po
#sed -i 's/TTYD 终端/命令终端/g' package/openwrt-packages/luci-app-ttyd/po/zh_Hans/terminal.po
sed -i 's/services/vpn/g'  package/openwrt-packages/luci-app-wechatpush/root/usr/share/luci/menu.d/luci-app-wechatpush.json

sed -i '/msgid "Pass Wall"/{n;s/PassWall/翻越长城/;}' package/openwrt-packages/small/luci-app-passwall/po/zh_Hans/passwall.po
sed -i '/Pass Wall/s/-1/4/g' package/openwrt-packages/small/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/small/luci-app-passwall/luasrc`

sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' package/openwrt-packages/luci-app-smartdns/po/zh_Hans/smartdns.po
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

sed -i 's/services/system/g' package/openwrt-packages/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i 's/msgstr "Watchcat"/msgstr "智能重启"/g' package/openwrt-packages/luci-app-watchcat/po/zh_Hans/watchcat.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' package/openwrt-packages/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-unblockmusic/luasrc`

##############自定义结束#################
