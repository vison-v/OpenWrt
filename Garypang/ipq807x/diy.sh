#!/bin/bash

shopt -s extglob

rm -rf package/kernel package/network
svn export --force https://github.com/Boos4721/openwrt/trunk/package/kernel package/kernel
svn export --force https://github.com/Boos4721/openwrt/trunk/package/network package/network
rm -rf package/lean package/libs/openssl
svn export --force https://github.com/openwrt/openwrt/branches/openwrt-22.03/package/libs/openssl package/libs/openssl


rm -rf target/linux
svn export --force https://github.com/Boos4721/openwrt/trunk/target/linux target/linux
rm -rf target/linux/generic/hack-5.15/531-debloat_lzma.patch target/linux/generic/hack-5.15/600-bridge_offload.patch

sed -i 's/autocore-arm /my-autocore-arm /' target/linux/ipq807x/Makefile
sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += luci-app-turboacc/' target/linux/ipq807x/Makefile

echo '
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_AES_ARM64=y
CONFIG_CRYPTO_AES_ARM64_BS=y
CONFIG_CRYPTO_AES_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_GHASH_ARM64_CE=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_ARM64_CE=y
CONFIG_CRYPTO_SHA256_ARM64=y
CONFIG_CRYPTO_SHA2_ARM64_CE=y
CONFIG_CRYPTO_SHA512_ARM64=y
CONFIG_CRYPTO_SIMD=y
CONFIG_REALTEK_PHY=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_MOTORCOMM_PHY=y
CONFIG_SENSORS_PWM_FAN=y
' >> ./target/linux/ipq807x/config-5.15
