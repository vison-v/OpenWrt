#!/bin/bash
sed -i 's/= 10/= 6/g' package/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/AdGuard Home/广告过滤/g' package/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/services/vpn/g'  `grep services -rl package/luci-app-adguardhome/luasrc`
echo -----------------START-------------------
