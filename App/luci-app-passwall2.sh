#!/bin/bash
sed -i '/msgid "PassWall 2"/{n;s/PassWall 2/翻越长城/;}' package/luci-app-passwall2/po/zh_Hans/passwall2.po
sed -i 's/services/vpn/g'  `grep services -rl package/luci-app-passwall2/luasrc`
echo -----------------START-------------------
