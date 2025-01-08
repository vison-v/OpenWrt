#!/bin/bash
sed -i 's/services/vp/g' package/luci-app-mihomo/root/usr/share/luci/menu.d/luci-app-mihomo.json
sed -i '/msgid "MihomoTProxy"/{n;s/msgstr ""/msgstr "翻越长城"/;}' package/luci-app-mihomo/po/zh_Hans/mihomo.po
echo -----------------START-------------------
