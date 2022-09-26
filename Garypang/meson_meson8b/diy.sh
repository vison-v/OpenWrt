#!/bin/bash

shopt -s extglob

echo "REPO_BRANCH=openwrt-22.03" >> $GITHUB_ENV || true

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/meson target/linux/meson
