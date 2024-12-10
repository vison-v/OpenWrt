#!/bin/bash
sed -i '/msgid "Pass Wall"/{n;s/PassWall/翻越长城/;}' package/luci-app-passwall/po/zh_Hans/passwall.po
sed -i 's/services/vpn/g'  `grep services -rl package/luci-app-passwall/luasrc`
echo -----------------START-------------------
