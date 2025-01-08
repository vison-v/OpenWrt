#!/bin/bash
sed -i 's/services/vp/g' package/luci-app-homeproxy/root/usr/share/luci/menu.d/luci-app-homeproxy.json
sed -i '/msgid "HomeProxy"/{n;s/HomeProxy/DNS 加速/;}' package/luci-app-homeproxy/po/zh_Hans/homeproxy.po
echo -----------------START-------------------
