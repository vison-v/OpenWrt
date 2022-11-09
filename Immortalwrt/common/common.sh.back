#!/bin/bash 
rm -Rf feeds/luci/applications/{luci-app-aliyundrive-webdav,luci-app-aliyundrive-fuse,luci-app-appfilter,luci-app-bypass,luci-app-adguardhome,luci-app-koolproxyR}
##############加载自定义app################
git clone https://github.com/sirpdboy/luci-app-wizard.git package/openwrt-packages/luci-app-wizard
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump
##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a
