#!/bin/bash
echo -e "\nmsgid \"ShadowSocksR Plus+\"" >> package/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
echo -e "msgstr \"跨越大河\"" >> package/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
sed -i '/ShadowSocksR Plus+/s/10/4/g' package/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' package/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
sed -i 's/services/vpn/g'  `grep services -rl package/luci-app-ssr-plus/luasrc`
echo -----------------START-------------------
