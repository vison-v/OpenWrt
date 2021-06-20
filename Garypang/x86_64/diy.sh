#!/bin/bash

rm -rf target/linux/x86
svn co https://github.com/openwrt/openwrt/trunk/target/linux/x86 target/linux/x86

sed -i 's/5.4/5.10/g' target/linux/x86/Makefile

rm -rf include/kernel-version.mk
wget -O include/kernel-version.mk https://raw.githubusercontent.com/openwrt/openwrt/master/include/kernel-version.mk

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
' >> ./target/linux/x86/64/config-5.10

sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
