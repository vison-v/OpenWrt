#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts -o target/linux/ipq40xx/files/arch/arm/boot/dts/qcom-ipq4019-cm520-79f.dts

echo '
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
' >> ./target/linux/ipq40xx/config-5.10

