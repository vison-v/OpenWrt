#!/bin/bash
##############用nginx替换uhpptd################
sed -i 's/+luci-light/+luci-nginx/g' feeds/luci/collections/luci/Makefile
echo -----------------FINISH-------------------
