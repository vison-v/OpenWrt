  
#!/bin/bash
#=================================================
rm -Rf feeds/packages/net/{smartdns,aria2} package/lean/{tcping,luci-app-baidupcs-web}
##############加载自定义app################
git clone https://github.com/garypang13/luci-app-baidupcs-web package/openwrt-packages/luci-app-baidupcs-web
git clone https://github.com/garypang13/luci-app-dnsfilter package/openwrt-packages/luci-app-dnsfilter
git clone https://github.com/garypang13/luci-app-bypass package/openwrt-packages/luci-app-bypass
svn co https://github.com/garypang13/openwrt-packages/trunk/aria2 package/openwrt-packages/aria2
svn co https://github.com/garypang13/openwrt-packages/trunk/smartdns package/openwrt-packages/smartdns
svn co https://github.com/garypang13/openwrt-packages/trunk/qBittorrent-Enhanced-Edition package/openwrt-packages/qBittorrent-Enhanced-Edition
svn co https://github.com/garypang13/openwrt-packages/trunk/chinadns-ng package/openwrt-packages/chinadns-ng
svn co https://github.com/garypang13/openwrt-packages/trunk/trojan-go package/openwrt-packages/trojan-go
svn co https://github.com/garypang13/openwrt-packages/trunk/trojan-plus package/openwrt-packages/trojan-plus
svn co https://github.com/garypang13/openwrt-packages/trunk/lua-maxminddb package/openwrt-packages/lua-maxminddb
svn co https://github.com/garypang13/openwrt-packages/trunk/tcping package/openwrt-packages/tcping
##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a
sed -i 's/BaiduPCS Web/百度网盘/g' package/openwrt-packages/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/+qBittorrent/+qBittorrent-Enhanced-Edition/g' package/lean/luci-app-qbittorrent/Makefile

sed -i 's/"Bypass"/"畅游国际"/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/model/cbi/bypass/client-config.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/model/cbi/bypass/server-config.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/model/cbi/bypass/server.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/model/cbi/bypass/servers.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/check.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/checkport.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/kcptun_version.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/refresh.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/server_list.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/status.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/status_bottom.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/subscribe.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/trojan_go_version.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/v2ray_version.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-bypass/luasrc/view/bypass/xray_version.htm

sed -i 's/DNSFilter/广告过滤/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/model/cbi/dnsfilter/base.lua
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/view/dnsfilter/dnsfilter_status.htm
sed -i 's/services/vpn/g' package/openwrt-packages/luci-app-dnsfilter/luasrc/view/dnsfilter/refresh.htm
