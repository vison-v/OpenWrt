#!/bin/bash 

##############加载自定义app################
git clone https://github.com/binge8/luci-app-koolddns.git package/openwrt-packages/luci-app-koolddns
##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a
##############自定义结束#################
