#!/bin/bash 
rm -Rf feeds/luci/applications/{luci-app-aliyundrive-webdav,luci-app-aliyundrive-fuse,luci-app-appfilter,luci-app-bypass,luci-app-adguardhome,luci-app-koolproxyR}
##############加载自定义app################
git clone https://github.com/sirpdboy/luci-app-wizard.git package/openwrt-packages/luci-app-wizard
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/openwrt-packages/luci-app-koolproxyR
git clone https://github.com/kiddin9/luci-app-dnsfilter package/openwrt-packages/luci-app-dnsfilter
svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/openwrt-packages/luci-app-bypass
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav package/openwrt-packages/luci-app-aliyundrive-webdav
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-fuse package/openwrt-packages/luci-app-aliyundrive-fuse

##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

sed -i 's/带宽监控/监控/g' package/emortal/default-settings/i18n/more.zh_Hans.po
sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po

sed -i 's/services/system/g'  feeds/luci/applications/luci-app-watchcat/root/usr/share/luci/menu.d/luci-app-watchcat.json
sed -i 's/msgstr "Watchcat"/msgstr "智能重启"/g' feeds/luci/applications/luci-app-watchcat/po/zh_Hans/watchcat.po
