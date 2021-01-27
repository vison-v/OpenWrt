#!/bin/bash

##############加载自定义app################
git clone https://github.com/KFERMercer/luci-app-tcpdump.git ./package/luci-app-tcpdump

##############菜单整理美化#################
./scripts/feeds update -a
#curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "VPN"/{n;s/VPN/酷软/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po

sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/applications/luci-app-opkg/po/zh_Hans/opkg.po

sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po

sed -i '/msgid "Terminal"/{n;s/终端/命令终端/;}' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po
sed -i '/"title": "Terminal",/a\		"order": 31,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json

sed -i '/msgid "uHTTPd"/{n;s/uHTTPd/网页服务/;}' feeds/luci/applications/luci-app-uhttpd/po/zh_Hans/uhttpd.po

sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po

sed -i '/msgid "Transmission"/{n;s/Transmission/BtPt下载/;}' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po

sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=+luci-compat +aria2 +luci-lib-ipkg +ariang/g' feeds/luci/applications/luci-app-aria2/Makefile
sed -i '/msgid "Aria2"/{n;s/Aria2/通用下载/;}' feeds/luci/applications/luci-app-aria2/po/zh_Hans/aria2.po
sed -i 's/services/nas/g'  `grep services -rl feeds/luci/applications/luci-app-aria2/luasrc`

sed -i 's/services/system/g' feeds/luci/applications/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i '/msgid "Watchcat"/{n;s/Watchcat/智能重启/;}' feeds/luci/applications/luci-app-watchcat/po/zh_Hans/watchcat.po
sed -i 's/"Reboot on internet connection lost"/"互联网连接丢失时重启"/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua
sed -i 's/"Periodic reboot"/"定期重启"/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua

sed -i '/msgid "KMS Server"/{n;s/KMS 服务器/KMS 服务/;}' feeds/custom/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

echo -e "\nmsgid \"Docker\"" >> feeds/custom/luci-app-dockerman/po/zh_Hans/dockerman.po
echo -e "msgstr \"容器\"" >> feeds/custom/luci-app-dockerman/po/zh_Hans/dockerman.po
sed -i '/"Docker"/s/40/45/' feeds/custom/luci-app-dockerman/luasrc/controller/dockerman.lua
#sed -i '/"Overview"/s/0/170/' feeds/custom/luci-app-dockerman/luasrc/controller/dockerman.lua

echo -e "\nmsgid \"Blacklist\"" >> feeds/custom/luci-app-control-webrestriction/po/zh_Hans/webrestriction.po
echo -e "msgstr \"黑名单\"" >> feeds/custom/luci-app-control-webrestriction/po/zh_Hans/webrestriction.po

#sed -i 's/44/43/g' feeds/custom/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/custom/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/USB 打印服务器/打印服务/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po

sed -i 's/IP\/MAC绑定/ARP绑定/g' feeds/custom/luci-app-arpbind/po/zh_Hans/arpbind.po

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/custom/luci-app-socat/po/zh_Hans/socat.po

sed -i 's/BaiduPCS Web/百度网盘/g' feeds/custom/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/"ZeroTier"/"内网穿透"/g' feeds/custom/luci-app-zerotier/luasrc/controller/zerotier.lua

#sed -i 's/+qBittorrent-Enhanced-Edition/+qBittorrent/g' feeds/custom/luci-app-qbittorrent/Makefile
echo -e "\nmsgid \"qBittorrent\"" >> feeds/custom/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> feeds/custom/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po

sed -i 's/aMule设置/电驴下载/g' feeds/custom/luci-app-amule/po/zh_Hans/amule.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-amule/po/zh_Hans/amule.po

sed -i 's/可道云/可道云盘/g' feeds/custom/luci-app-kodexplorer/po/zh_Hans/kodexplorer.po

sed -i 's/88/89/g' feeds/custom/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/89/88/g' feeds/custom/luci-app-filetransfer/luasrc/controller/filetransfer.lua

sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/custom/luci-app-turboacc/po/zh_Hans/turboacc.po

sed -i 's/TTYD 终端/命令终端/g' feeds/custom/luci-app-ttyd/po/zh_Hans/terminal.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' feeds/custom/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-unblockmusic/luasrc`

sed -i 's/上网时间控制/时间控制/g' feeds/custom/luci-app-accesscontrol/po/zh_Hans/mia.po
sed -i 's/services/control/g'  `grep services -rl feeds/custom/luci-app-accesscontrol/luasrc`

mv package/luci-app-tcpdump/po/zh-cn package/luci-app-tcpdump/po/zh_Hans
sed -i 's/Tcpdump 流量监控/流量捕获/g' package/luci-app-tcpdump/po/zh_Hans/tcpdump.po

sed -i 's/network/control/g'  `grep network -rl feeds/custom/luci-app-oaf/luasrc`

sed -i 's/network/control/g'  `grep network -rl feeds/custom/luci-app-eqos/luasrc`
sed -i '/msgid "EQoS"/{n;s/IP限速/网速控制/;}' feeds/custom/luci-app-eqos/po/zh_Hans/eqos.po

sed -i 's/CPU 性能优化调节/CPU 调节/g' feeds/custom/luci-app-cpufreq/po/zh_Hans/cpufreq.po

sed -i 's/带宽监控/监控/g' feeds/custom/default-settings/po/zh_Hans/more.zh_Hans.po

sed -i 's/KMS 服务器/KMS 服务/g' feeds/custom/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-passwall/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-jd-dailybonus/luasrc`
sed -i 's/京东签到服务/京东签到/g' feeds/custom/luci-app-jd-dailybonus/po/zh_Hans/jd-dailybonus.po

sed -i 's/services/vpn/g' feeds/custom/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json
sed -i '/"title": "SmartDNS",/a\		"order": 3,' feeds/custom/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-koolproxyR/files/usr/lib/lua/luci`

sed -i 's/AdGuard Home/AdGuard/g' feeds/custom/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-adguardhome/luasrc`

#sed -i 's/Adblock Plus+/广告过滤/g' feeds/custom/luci-app-adblock-plus/luasrc/controller/adblock-plus.lua
#sed -i 's/services/vpn/g' grep services -rl feeds/custom/luci-app-adblock-plus/luasrc

sed -i 's/DNSFilter/广告过滤/g' feeds/custom/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-dnsfilter/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-openclash/luasrc`

sed -i 's/"ShadowSocksR Plus+"/"畅游国际"/g' feeds/custom/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-ssr-plus/luasrc`
sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' feeds/custom/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po

sed -i 's/"Bypass"/"畅游国际"/g' feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-bypass/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl feeds/custom/luci-app-serverchan/luasrc`
