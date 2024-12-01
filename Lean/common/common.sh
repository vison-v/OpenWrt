#!/bin/bash 

rm -Rf feeds/packages/net/{smartdns,aria2,adguardhome} feeds/luci/themes/luci-theme-argon feeds/luci/applications/{luci-app-netdata,luci-app-baidupcs-web,luci-app-dockerman}
##############加载自定义app################

function git_clone() {
          git clone --depth 1 $1 $2
          if [ "$?" != 0 ]; then
            echo "error on $1"
            pid="$( ps -q $$ )"
            kill $pid
          fi
        }
function git_sparse_clone() {
          branch="$1" rurl="$2" localdir="$3" && shift 3
          git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
          if [ "$?" != 0 ]; then
            echo "error on $rurl"
            pid="$( ps -q $$ )"
            kill $pid
          fi
          cd $localdir
          git sparse-checkout init --cone
          git sparse-checkout set $@
          mv -n $@ ../ || true
          cd ..
          rm -rf $localdir
          }
function mvdir() {
        mv -n `find $1/* -maxdepth 0 -type d` ./
        rm -rf $1
        }
        
#git_clone https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash package/openwrt-packages/luci-app-openclash ; rm -rf OpenClash
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomato.git package/openwrt-packages/luci-theme-opentomato
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter
#git_clone https://github.com/apollo-ng/luci-theme-darkmatter && mv -n luci-theme-darkmatter/luci package/openwrt-packages/luci-theme-darkmatter ; rm -rf luci-theme-darkmatter
#git clone https://github.com/binge8/luci-app-koolddns.git package/openwrt-packages/luci-app-koolddns
#git_clone https://github.com/lisaac/luci-app-dockerman.git && mv -n luci-app-dockerman/applications/luci-app-dockerman package/openwrt-packages/luci-app-dockerman ; rm -rf luci-app-dockerman   

git clone https://github.com/kenzok8/small.git package/openwrt-packages/small
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

#git clone https://github.com/sirpdboy/luci-app-netdata package/openwrt-packages/luci-app-netdata
#git clone https://github.com/sirpdboy/luci-theme-opentopd package/openwrt-packages/luci-theme-opentopd
#git clone https://github.com/sirpdboy/luci-app-netwizard package/openwrt-packages/luci-app-netwizard

#git clone https://github.com/jerrykuku/luci-app-vssr.git package/openwrt-packages/luci-app-vssr
git clone https://github.com/jerrykuku/luci-app-argon-config.git -b 18.06 package/openwrt-packages/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06 package/openwrt-packages/luci-theme-argon
#git clone https://github.com/jerrykuku/node-request.git package/openwrt-packages/node-request

git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump

git clone https://github.com/pymumu/luci-app-smartdns -b lede package/openwrt-packages/luci-app-smartdns
git clone https://github.com/pymumu/openwrt-smartdns.git package/openwrt-packages/smartdns

git_clone https://github.com/Lienol/openwrt-package.git && mv -n openwrt-package/{luci-app-control-timewol,luci-app-control-webrestriction,luci-app-control-weburl} package/openwrt-packages/; rm -rf openwrt-package

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

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

sed -i '18,30d' package/lean/default-settings/files/zzz-default-settings

sed -i '/msgid "Hostnames"/{n;s/主机名/主机映射/;}' feeds/luci/modules/luci-base/po/zh-cn/base.po

sed -i 's/OpenWrt /OpenWrt Build By ViS0N /' package/lean/default-settings/files/zzz-default-settings
