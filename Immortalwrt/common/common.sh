#!/bin/bash 
rm -Rf feeds/luci/applications/luci-app-eqosplus
##############自定义git clone################
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
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump
git_sparse_clone main "https://github.com/kiddin9/kwrt-packages.git" luci-app-eqosplus luci-app-nginx-manager
git_sparse_clone main "https://github.com/Lienol/openwrt-package.git" luci-app-control-webrestriction luci-app-control-weburl
##--------------------------##
mv -n luci-* package/openwrt-packages/
##############转换app语言包################
curl -fsSL  https://raw.githubusercontent.com/vison-v/OpenWrt/main/Immortalwrt/common/custom.sh >> package/openwrt-packages/custom.sh
chmod +x package/openwrt-packages/custom.sh && bash package/openwrt-packages/custom.sh
##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a

curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/I.base >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/DISTRIB_DESCRIPTION/d' package/base-files/files/etc/openwrt_release
echo "DISTRIB_DESCRIPTION='ImmortalWrt Build By ViS0N '" >> package/base-files/files/etc/openwrt_release

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

sed -i '/msgid "Reboot"/{n;s/"重启"/"立即重启"/;}' feeds/luci/applications/luci-app-advanced-reboot/po/zh_Hans/advanced-reboot.po

sed -i 's/msgstr "网络存储"/msgstr "存储"/g' feeds/luci/applications/luci-app-vsftpd/po/zh_Hans/vsftpd.po
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po

sed -i 's/40)./45)./g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/dockerman.lua
sed -i 's/msgstr "Docker"/msgstr "容器"/g' feeds/luci/applications/luci-app-dockerman/po/zh_Hans/dockerman.po

sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po

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

#sed -i 's/msgstr "IP\/MAC绑定"/msgstr "地址绑定"/g' feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po
sed -i 's/"IP\/MAC Binding"/"地址绑定"/g' feeds/luci/applications/luci-app-arpbind/luasrc/controller/arpbind.lua
echo -e "\nmsgid \"Rules\"" >> feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po
echo -e "msgstr \"规则\"" >> feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po

sed -i '/msgid "ZeroTier"/{n;s/msgstr "ZeroTier"/msgstr "内网穿透"/;}' feeds/luci/applications/luci-app-zerotier/po/zh_Hans/zerotier.po

sed -i 's/msgstr "MultiWAN 管理器"/msgstr "多播管理"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/luci/applications/luci-app-socat/po/zh_Hans/socat.po

sed -i 's/msgstr "ACME 证书"/msgstr "自动证书"/g' feeds/luci/applications/luci-app-acme/po/zh_Hans/acme.po

sed -i 's/msgstr "软件包"/msgstr "软件管理"/g' feeds/luci/applications/luci-app-package-manager/po/zh_Hans/package-manager.po

sed -i 's/Setting/其它设置/g' feeds/luci/applications/luci-app-netdata/luasrc/controller/netdata.lua

echo -e "\nmsgid \"qBittorrent\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po

sed -i 's/aMule设置/电驴下载/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po

#sed -i 's/可道云/可道云盘/g' feeds/luci/applications/luci-app-kodexplorer/po/zh_Hans/kodexplorer.po

sed -i 's/88/89/g' feeds/luci/applications/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/luci/applications/luci-app-cifs-mount/po/zh_Hans/cifs.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/msgstr "Rclone"/msgstr "挂载网盘"/g' feeds/luci/applications/luci-app-rclone/po/zh_Hans/luci-app-rclone.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-nfs/luasrc/controller/nfs.lua

#sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua

#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh_Hans/turboacc.po

sed -i 's/解除网易云音乐播放限制/网易音乐/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json

sed -i 's/services/control/g'  `grep services -rl feeds/luci/applications/luci-app-appfilter/luasrc`
sed -i 's/"control"/"services"/g'  `grep control -rl feeds/luci/applications/luci-app-timewol/luasrc`

sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/luci/applications/luci-app-argon-config/po/zh_Hans/argon-config.po

sed -i 's/services/control/g' feeds/luci/applications/luci-app-eqos/root/usr/share/luci/menu.d/luci-app-eqos.json
sed -i '/msgid "EQoS"/{n;s/IP限速/网速控制/;}' feeds/luci/applications/luci-app-eqos/po/zh_Hans/eqos.po

sed -i 's/CPU 性能优化调节/CPU 调节/g' feeds/luci/applications/luci-app-cpufreq/po/zh_Hans/cpufreq.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po
sed -i 's/admin\/services\/nlbw/admin\/nlbw/g' feeds/luci/applications/luci-app-nlbwmon/root/usr/share/luci/menu.d/luci-app-nlbwmon.json

sed -i 's/services/system/g'  feeds/luci/applications/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i 's/msgstr "Watchcat"/msgstr "智能重启"/g' feeds/luci/applications/luci-app-watchcat/po/zh_Hans/watchcat.po

sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-wechatpush/root/usr/share/luci/menu.d/luci-app-wechatpush.json

sed -i 's/msgstr "Aria2"/msgstr "通用下载"/g' feeds/luci/applications/luci-app-aria2/po/zh_Hans/aria2.po

sed -i '/msgid "Transmission"/{n;s/Transmission/BtPt下载/;}' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po

sed -i 's/msgstr "UPnP IGD 和 PCP"/msgstr "UPnP服务"/g' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

sed -i 's/KMS 服务器/KMS 服务/g' feeds/luci/applications/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-haproxy-tcp/luasrc/controller/haproxy.lua
sed -i 's/"HAProxy"/"负载优选"/g' feeds/luci/applications/luci-app-haproxy-tcp/luasrc/controller/haproxy.lua

##---------------------------------------------------------------------------------------------------------##
sed -i 's/msgstr "Tcpdump 流量监控"/msgstr "流量监控"/g' package/openwrt-packages/luci-app-tcpdump/po/zh_Hans/tcpdump.po

sed -i '/msgid "Pass Wall"/{n;s/PassWall/翻越长城/;}' feeds/luci/applications/luci-app-passwall/po/zh_Hans/passwall.po
sed -i '/Pass Wall/s/-1/4/g' feeds/luci/applications/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-passwall/luasrc`

#sed -i '/Bypass/s/2/8/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
#sed -i 's/Bypass/世界,你好/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-bypass/luasrc`

#sed -i '/msgid "OpenClash"/{n;s/OpenClash/世界,你好/;}' package/openwrt-packages/luci-app-openclash/po/zh_Hans/openclash.po
#sed -i '/OpenClash/s/50/3/g' package/openwrt-packages/luci-app-openclash/luasrc/controller/openclash.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-openclash/luasrc`

#echo -e "\nmsgid \"ShadowSocksR Plus+\"" >> package/openwrt-packages/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
#echo -e "msgstr \"跨越大河\"" >> package/openwrt-packages/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
#sed -i '/ShadowSocksR Plus+/s/10/4/g' package/openwrt-packages/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' package/openwrt-packages/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-ssr-plus/luasrc`

#sed -i '/Hello World/s/0/5/g' package/openwrt-packages/luci-app-vssr/luasrc/controller/vssr.lua
#sed -i 's/Hello World/世界,你好/g' package/openwrt-packages/luci-app-vssr/luasrc/controller/vssr.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-vssr/luasrc`

sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' feeds/luci/applications/luci-app-smartdns/po/zh_Hans/smartdns.po
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

#sed -i 's/= 10/= 6/g' package/openwrt-packages/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
#sed -i 's/AdGuard Home/广告过滤/g' package/openwrt-packages/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-adguardhome/luasrc`

#sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' feeds/luci/applications/luci-app-adbyby-plus/po/zh_Hans/adbyby.po
#sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-adbyby-plus/luasrc`

#sed -i '/KoolProxyR plus+/s/1/7/g' package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
#sed -i 's/KoolProxyR plus+/广告过滤/g' package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci`

#sed -i '/DNSFilter/s/1/8/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
#sed -i 's/DNSFilter/广告过滤/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
#sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-dnsfilter/luasrc`

##############自定义结束#################
