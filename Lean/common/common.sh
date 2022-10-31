#!/bin/bash 

rm -Rf feeds/packages/net/{smartdns,aria2,adguardhome} feeds/luci/themes/luci-theme-argon feeds/luci/applications/{luci-app-netdata,luci-app-baidupcs-web,luci-app-dockerman}
##############加载自定义app################
git submodule add -f --name helloworld https://github.com/fw876/helloworld.git package/openwrt-packages/luci-app-ssr-plus
git submodule update --remote package/openwrt-packages/luci-app-ssr-plus

git clone https://github.com/vernesong/OpenClash.git package/openwrt-packages/OpenClash
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/openwrt-packages/luci-app-koolproxyR
git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/openwrt-packages/luci-theme-opentomato
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/openwrt-packages/luci-theme-rosy
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter
git clone https://github.com/CCnut/feed-netkeeper.git -b LUCI-LUA-UCITRACK package/openwrt-packages/netkeeper
svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci package/openwrt-packages/luci-theme-darkmatter
git clone https://github.com/binge8/luci-app-koolddns.git package/openwrt-packages/luci-app-koolddns
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/openwrt-packages/luci-app-dockerman

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/openwrt-packages/luci-app-eqos
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-passwall package/openwrt-packages/luci-app-passwall

git clone https://github.com/sirpdboy/luci-app-netdata package/openwrt-packages/luci-app-netdata
git clone https://github.com/sirpdboy/luci-theme-opentopd package/openwrt-packages/luci-theme-opentopd
git clone https://github.com/sirpdboy/luci-app-wizard.git package/openwrt-packages/luci-app-wizard

git clone https://github.com/jerrykuku/luci-app-vssr.git package/openwrt-packages/luci-app-vssr
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/openwrt-packages/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/openwrt-packages/luci-theme-argon
git clone https://github.com/jerrykuku/node-request.git package/openwrt-packages/node-request

git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump

git clone https://github.com/pymumu/luci-app-smartdns -b lede package/openwrt-packages/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git package/openwrt-packages/smartdns

svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol package/openwrt-packages/luci-app-control-timewol
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction package/openwrt-packages/luci-app-control-webrestriction
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl package/openwrt-packages/luci-app-control-weburl

svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-aliddns package/openwrt-packages/luci-app-aliddns
git clone https://github.com/kiddin9/luci-app-baidupcs-web package/openwrt-packages/luci-app-baidupcs-web
git clone https://github.com/kiddin9/luci-app-dnsfilter package/openwrt-packages/luci-app-dnsfilter
svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/openwrt-packages/luci-app-bypass
svn co https://github.com/kiddin9/openwrt-packages/trunk/aria2 package/openwrt-packages/aria2
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
svn co https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/openwrt-packages/adguardhome
svn co https://github.com/kiddin9/openwrt-packages/trunk/qBittorrent-Enhanced-Edition package/openwrt-packages/qBittorrent-Enhanced-Edition
svn co https://github.com/kiddin9/openwrt-packages/trunk/lua-maxminddb package/openwrt-packages/lua-maxminddb
##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a

#getversion(){
#ver=$(basename $(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$1/releases/latest) | grep -o -E "[0-9].+")
#[ $ver ] && echo $ver || git ls-remote --tags git://github.com/$1 | cut -d/ -f3- | sort -t. -nk1,2 -k3 | awk '/^[^{]*$/{version=$1}END{print version}' | grep -o -E "[0-9].+"
#}
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion AdguardTeam/AdGuardHome)/g" package/openwrt-packages/adguardhome/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" package/openwrt-packages/adguardhome/Makefile
#sed -i "s/LUCI_DEPENDS:=.*/LUCI_DEPENDS:=+ca-certs +curl +wget +PACKAGE_$(PKG_NAME)_INCLUDE_binary:AdGuardHome/g" package/openwrt-packages/luci-app-adguardhome/Makefile
#rm -Rf package/openwrt-packages/luci-app-adguardhome/po/zh_Hans && svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome/po/zh_Hans package/openwrt-packages/luci-app-adguardhome/po/zh-cn

#rm -Rf package/openwrt-packages/luci-app-aliddns/po/zh_Hans && svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-aliddns/po/zh_Hans package/openwrt-packages/luci-app-aliddns/po/zh-cn
#curl -fsSL  https://raw.githubusercontent.com/vison-v/aria2/main/transmission > feeds/packages/net/transmission/Makefile
#curl -fsSL  https://raw.githubusercontent.com/vison-v/aria2/main/transmission-web-control > feeds/packages/net/transmission-web-control/Makefile
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$(getversion ronggang/transmission-web-control)/g" feeds/packages/net/transmission-web-control/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

sed -i '18,30d' package/lean/default-settings/files/zzz-default-settings

sed -i '1391s/主机名/主机映射/g' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i 's/OpenWrt /OpenWrt Build By ViS0N /' package/lean/default-settings/files/zzz-default-settings

sed -i '/localtime  = os.date()/s/()/("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i '/local cpu_usage/a\\t\tlocal up_time = luci.sys.exec("cntime")' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i "s/String.format('%t', info.uptime)/info.uptime/" package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i 's/= sysinfo.uptime or 0/= up_time/' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i '/$(INSTALL_DIR) $(1)\/sbin/a\\t$(INSTALL_BIN) .\/files\/generic\/cntime $(1)\/sbin\/cntime' package/lean/autocore/Makefile

sed -i 's/%D %V, %C/%D %V, %C, Build By ViS0N/g' package/base-files/files/etc/banner

curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i 's/40)./45)./g' package/openwrt-packages/luci-app-dockerman/luasrc/controller/dockerman.lua

sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po

sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh-cn/minidlna.po

sed -i 's/IP\/MAC 绑定/地址绑定/g' feeds/luci/applications/luci-app-arpbind/po/zh-cn/arpbind.po

sed -i 's/"ZeroTier"/"内网穿透"/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua

sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-diag-core/po/zh-cn/diag_core.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' package/lean/default-settings/po/zh-cn/more.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-mwan3/po/zh-cn/mwan3.po

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/luci/applications/luci-app-socat/po/zh-cn/socat.po

sed -i 's/BaiduPCS Web/百度网盘/g' package/openwrt-packages/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/msgstr "设置向导"/msgstr "向导"/g' package/openwrt-packages/luci-app-wizard/files/luci/i18n/wizard.zh-cn.po
sed -i "s/lan_ipaddr '*.*.*.*'/lan_ipaddr '192.168.10.1'/g" package/openwrt-packages/luci-app-wizard/files/root/etc/config/wizard

sed -i 's/Setting/其它设置/g' package/openwrt-packages/luci-app-netdata/luasrc/controller/netdata.lua

echo -e "\nmsgid \"qBittorrent\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh-cn/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh-cn/qbittorrent.po
sed -i 's/+qBittorrent/+qBittorrent-Enhanced-Edition/g' feeds/luci/applications/luci-app-qbittorrent/Makefile

sed -i 's/aMule设置/电驴下载/g' feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po

sed -i 's/可道云/可道云盘/g' feeds/luci/applications/luci-app-kodexplorer/po/zh-cn/kodexplorer.po

sed -i 's/88/89/g' feeds/luci/applications/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/luci/applications/luci-app-cifs-mount/po/zh-cn/cifs.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/msgstr "Rclone"/msgstr "挂载网盘"/g' feeds/luci/applications/luci-app-rclone/po/zh_Hans/rclone.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-nfs/luasrc/controller/nfs.lua

sed -i 's/90/89/g' feeds/luci/applications/luci-app-watchcat/luasrc/controller/watchcat.lua

sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua

sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

sed -i 's/TTYD 终端/命令终端/g' feeds/luci/applications/luci-app-ttyd/po/zh-cn/terminal.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' feeds/luci/applications/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-unblockmusic/luasrc`


sed -i 's/阿里云盘 WebDAV/阿里云盘/g' feeds/luci/applications/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-aliyundrive-webdav/luasrc`

sed -i 's/阿里云盘 FUSE/云盘FUSE/g' feeds/luci/applications/luci-app-aliyundrive-fuse/po/zh-cn/aliyundrive-fuse.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-aliyundrive-fuse/luasrc`

sed -i '/msgid "UU GameAcc"/{n;s/UU游戏加速器/UU加速器/;}' feeds/luci/applications/luci-app-uugamebooster/po/zh-cn/uuplugin.po

sed -i 's/上网时间控制/时间控制/g' feeds/luci/applications/luci-app-accesscontrol/po/zh-cn/mia.po
sed -i 's/services/control/g'  `grep services -rl feeds/luci/applications/luci-app-accesscontrol/luasrc`

sed -i 's/Tcpdump 流量监控/流量监控/g' package/openwrt-packages/luci-app-tcpdump/po/zh-cn/tcpdump.po

sed -i 's/services/control/g'  `grep network -rl package/openwrt-packages/OpenAppFilter/luci-app-oaf/luasrc`

sed -i 's/90/56/g' package/openwrt-packages/luci-app-argon-config/luasrc/controller/argon-config.lua
sed -i 's/"Argon 主题设置"/"主题设置"/g' package/openwrt-packages/luci-app-argon-config/po/zh-cn/argon-config.po

sed -i 's/network/control/g'  `grep network -rl package/openwrt-packages/luci-app-eqos/luasrc`
sed -i '/msgid "EQoS"/{n;s/IP限速/网速控制/;}' package/openwrt-packages/luci-app-eqos/po/zh_Hans/eqos.po

sed -i 's/CPU 性能优化调节/CPU 调节/g' feeds/luci/applications/luci-app-cpufreq/po/zh-cn/cpufreq.po

sed -i 's/带宽监控/监控/g' package/lean/default-settings/po/zh-cn/more.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po

sed -i 's/services/system/g'  `grep services -rl feeds/luci/applications/luci-app-watchcat/luasrc`
sed -i '50s/WatchCat/智能重启/g' feeds/luci/applications/luci-app-watchcat/po/zh-cn/watchcat.po
sed -i '17s/Reboot on internet connection lost/互联网连接丢失时重启/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua
sed -i '18s/Periodic reboot/定期重启/g' feeds/luci/applications/luci-app-watchcat/luasrc/model/cbi/watchcat/watchcat.lua

sed -i 's/services/nas/g'  `grep services -rl feeds/luci/applications/luci-app-aria2/luasrc`
sed -i 's/Aria2 配置/通用下载/g' feeds/luci/applications/luci-app-aria2/po/zh-cn/aria2.po

sed -i '/msgid "Transmission"/{n;s/Transmission/BtPt下载/;}' feeds/luci/applications/luci-app-transmission/po/zh-cn/transmission.po

sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po

sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i 's/KMS 服务器/KMS 服务/g' feeds/luci/applications/luci-app-vlmcsd/po/zh-cn/vlmcsd.po

sed -i '/msgid "Pass Wall"/{n;s/PassWall/世界,你好/;}' package/openwrt-packages/luci-app-passwall/luci-app-passwall/po/zh-cn/passwall.po
#sed -i '/Pass Wall/s/1/8/g' package/openwrt-packages/luci-app-passwall/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-passwall/luci-app-passwall/luasrc`

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
#sed -i '/Bypass/s/2/8/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/Bypass/世界,你好/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-bypass/luasrc`

sed -i '/msgid "OpenClash"/{n;s/OpenClash/世界,你好/;}' package/openwrt-packages/OpenClash/luci-app-openclash/po/zh-cn/openclash.zh-cn.po
sed -i '/OpenClash/s/50/3/g' package/openwrt-packages/OpenClash/luci-app-openclash/luasrc/controller/openclash.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/OpenClash/luci-app-openclash/luasrc`

echo -e "\nmsgid \"ShadowSocksR Plus+\"" >> package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po
echo -e "msgstr \"翻越长城\"" >> package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po
sed -i '/ShadowSocksR Plus+/s/10/4/g' package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/po/zh-cn/ssr-plus.po
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-ssr-plus/luci-app-ssr-plus/luasrc`

sed -i '/Hello World/s/0/5/g' package/openwrt-packages/luci-app-vssr/luasrc/controller/vssr.lua
sed -i 's/Hello World/世界,你好/g' package/openwrt-packages/luci-app-vssr/luasrc/controller/vssr.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-vssr/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-jd-dailybonus/luasrc`
sed -i '/京东签到服务/s/10/11/g' package/openwrt-packages/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua
sed -i 's/'京东签到服务'/'京东签到'/g' package/openwrt-packages/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua

sed -i '/SmartDNS/s/60/9/g' package/openwrt-packages/luci-app-smartdns/luasrc/controller/smartdns.lua
sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' package/openwrt-packages/luci-app-smartdns/po/zh-cn/smartdns.po
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-smartdns/luasrc`

sed -i 's/= 10/= 6/g' package/openwrt-packages/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/AdGuard Home/广告过滤/g' package/openwrt-packages/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-adguardhome/luasrc`

sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' feeds/luci/applications/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-adbyby-plus/luasrc`

sed -i '/KoolProxyR plus+/s/1/7/g' package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
sed -i 's/KoolProxyR plus+/广告过滤/g' package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-koolproxyR/files/usr/lib/lua/luci`

#sed -i '/DNSFilter/s/1/8/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
sed -i 's/DNSFilter/广告过滤/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-dnsfilter/luasrc`

sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-serverchan/luasrc`

##############自定义结束#################
