#!/bin/bash

##############加载自定义app################
git clone https://github.com/fw876/helloworld.git package/openwrt-packages/luci-app-ssr-plus
git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/openwrt-packages/luci-theme-opentomato
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/openwrt-packages/luci-theme-rosy
git clone https://github.com/vernesong/OpenClash.git package/openwrt-packages/OpenClash
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
svn co https://github.com/garypang13/openwrt-packages/trunk/AdGuardHome package/openwrt-packages/adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-tcpdump package/openwrt-packages/luci-app-tcpdump
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/openwrt-packages/luci-app-koolproxyR
svn co https://github.com/garypang13/openwrt-packages/trunk/luci-app-serverchan package/openwrt-packages/luci-app-serverchan
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/openwrt-packages/luci-app-socat
git clone https://github.com/pymumu/luci-app-smartdns -b lede package/openwrt-packages/luci-app-smartdns
svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci package/openwrt-packages/luci-theme-darkmatter
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/openwrt-packages/luci-app-eqos
git clone https://github.com/jerrykuku/node-request.git package/openwrt-packages/node-request
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/openwrt-packages/luci-app-jd-dailybonus
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/openwrt-packages/luci-app-dockerman
#git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-packages/luci-app-passwall
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol package/openwrt-packages/luci-app-control-timewol
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction package/openwrt-packages/luci-app-control-webrestriction
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl package/openwrt-packages/luci-app-control-weburl
svn co https://github.com/garypang13/openwrt-packages/trunk/luci-app-aliddns package/openwrt-packages/luci-app-aliddns