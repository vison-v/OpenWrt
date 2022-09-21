#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

bash $SHELL_FOLDER/../common/kernel_5.15.sh

rm -rf package/boot/uboot-envtools package/firmware/ipq-wifi package/firmware/ath11k* package/kernel/mac80211
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/boot/uboot-envtools package/boot/uboot-envtools
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/firmware/ipq-wifi package/firmware/ipq-wifi
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/firmware/ath11k-firmware package/firmware/ath11k-firmware
svn export --force https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/package/kernel/mac80211 package/kernel/mac80211

svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/target/linux/generic/pending-5.15 target/linux/generic/pending-5.15

svn co https://github.com/robimarko/openwrt/branches/ipq807x-5.15-pr/target/linux/ipq807x target/linux/ipq807x

git clone https://github.com/robimarko/nss-packages --depth 1 package/nss-packages

curl -sfL https://raw.githubusercontent.com/robimarko/openwrt/ipq807x-5.15-pr/include/kernel-5.15 -o include/kernel-5.15
kernel_v="$(cat include/kernel-5.15 | grep LINUX_KERNEL_HASH-* | cut -f 2 -d - | cut -f 1 -d ' ')"
echo "KERNEL=${kernel_v}" >> $GITHUB_ENV || true
sed -i "s?targets/%S/.*'?targets/%S/$kernel_v'?" include/feeds.mk

curl -sfL https://raw.githubusercontent.com/robimarko/openwrt/ipq807x-5.15-pr/package/kernel/linux/modules/netsupport.mk -o package/kernel/linux/modules/netsupport.mk

curl -sfL https://raw.githubusercontent.com/Boos4721/openwrt/master/target/linux/ipq807x/patches-5.15/700-ipq8074-overclock-cpu-2.2ghz.patch -o target/linux/ipq807x/patches-5.15/700-ipq8074-overclock-cpu-2.2ghz.patch
sh -c "curl -sfL https://github.com/coolsnowwolf/lede/commit/06fcdca1bb9c6de6ccd0450a042349892b372220.patch | patch -d './' -p1 --forward"
rm -rf package/kernel/mt76

echo "
CONFIG_PACKAGE_kmod-ipt-coova=n
CONFIG_PACKAGE_kmod-pf-ring=n
" >> devices/common/.config

