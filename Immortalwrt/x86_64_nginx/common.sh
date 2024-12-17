#!/bin/bash
##############用nginx替换uhpptd################
rm -rf feeds/luci/collections/luci-light/Makefile && curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/Makefile >> feeds/luci/collections/luci-light/Makefile
echo "---------设置完成---------"
