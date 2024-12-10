#!/bin/bash
sed -i '/SmartDNS/s/60/9/g' package/luci-app-smartdns/luasrc/controller/smartdns.lua
sed -i '/msgid "SmartDNS"/{n;s/SmartDNS/DNS 加速/;}' package/luci-app-smartdns/po/zh_Hans/smartdns.po
sed -i 's/services/vpn/g'  `grep services -rl package/luci-app-smartdns/luasrc`
echo -----------------START-------------------
