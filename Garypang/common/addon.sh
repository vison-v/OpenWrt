#!/bin/bash

##############加载自定义app################
git clone https://github.com/KFERMercer/luci-app-tcpdump.git ./package/luci-app-tcpdump

##############菜单整理美化#################
./scripts/feeds update -a
#curl -fsSL  https://raw.githubusercontent.com/vison-v/patches/main/base >> feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/重启/立即重启/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "VPN"/{n;s/VPN/酷软/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po

sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/applications/luci-app-opkg/po/zh_Hans/opkg.po

sed -i '/msgid "miniDLNA"/{n;s/miniDLNA/DLNA服务/;}' feeds/luci/applications/luci-app-minidlna/po/zh_Hans/minidlna.po

sed -i '/msgid "Terminal"/{n;s/终端/命令终端/;}' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po
sed -i '/"title": "Terminal",/a\		"order": 31,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json

sed -i '/msgid "uHTTPd"/{n;s/uHTTPd/网页服务/;}' feeds/luci/applications/luci-app-uhttpd/po/zh_Hans/uhttpd.po

sed -i '/msgid "UPnP"/{n;s/UPnP/UPnP服务/;}' feeds/luci/applications/luci-app-upnp/po/zh_Hans/upnp.po

sed -i 's/带宽监控/监控/g' feeds/luci/applications/luci-app-nlbwmon/po/zh_Hans/nlbwmon.po

sed -i '/msgid "Transmission"/{n;s/Transmission/BtPt下载/;}' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po

sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aria2/luasrc/controller/aria2.lua
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aria2/luasrc/view/aria2/log_template.htm
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-aria2/luasrc/view/aria2/settings_header.htm
sed -i '/msgid "Aria2"/{n;s/Aria2/通用下载/;}' feeds/luci/applications/luci-app-aria2/po/zh_Hans/aria2.po

sed -i '/msgid "KMS Server"/{n;s/KMS 服务器/KMS 服务/;}' feeds/custom/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

echo -e "\nmsgid \"Docker\"" >> feeds/custom/luci-app-dockerman/po/zh_Hans/dockerman.po
echo -e "msgstr \"容器\"" >> feeds/custom/luci-app-dockerman/po/zh_Hans/dockerman.po
sed -i '13s/40/45/g' feeds/custom/luci-app-dockerman/luasrc/controller/dockerman.lua

echo -e "\nmsgid \"Blacklist\"" >> feeds/custom/luci-app-control-webrestriction/po/zh_Hans/webrestriction.po
echo -e "msgstr \"黑名单\"" >> feeds/custom/luci-app-control-webrestriction/po/zh_Hans/webrestriction.po

#sed -i 's/44/43/g' feeds/custom/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/custom/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/USB 打印服务器/打印服务/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po

sed -i 's/IP\/MAC绑定/ARP绑定/g' feeds/custom/luci-app-arpbind/po/zh_Hans/arpbind.po

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/custom/luci-app-socat/po/zh_Hans/socat.po

sed -i 's/BaiduPCS Web/百度网盘/g' feeds/custom/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/"ZeroTier"/"内网穿透"/g' feeds/custom/luci-app-zerotier/luasrc/controller/zerotier.lua

echo -e "\nmsgid \"qBittorrent\"" >> feeds/custom/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> feeds/custom/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po

sed -i 's/aMule设置/电驴下载/g' feeds/custom/luci-app-amule/po/zh_Hans/amule.po
sed -i 's/网络存储/存储/g' feeds/custom/luci-app-amule/po/zh_Hans/amule.po

sed -i 's/可道云/可道云盘/g' feeds/custom/luci-app-kodexplorer/po/zh_Hans/kodexplorer.po

sed -i 's/88/89/g' feeds/custom/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/89/88/g' feeds/custom/luci-app-filetransfer/luasrc/controller/filetransfer.lua

sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/custom/luci-app-turboacc/po/zh_Hans/turboacc.po

sed -i 's/TTYD 终端/命令终端/g' feeds/custom/luci-app-ttyd/po/zh_Hans/terminal.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' feeds/custom/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
sed -i 's/services/vpn/g' feeds/custom/luci-app-unblockmusic/luasrc/controller/unblockmusic.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-unblockmusic/luasrc/model/cbi/unblockmusic.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-unblockmusic/luasrc/view/unblockmusic/unblockmusic_status.htm

sed -i 's/上网时间控制/时间控制/g' feeds/custom/luci-app-accesscontrol/po/zh_Hans/mia.po
sed -i 's/services/control/g' feeds/custom/luci-app-accesscontrol/luasrc/controller/mia.lua
sed -i 's/services/control/g' feeds/custom/luci-app-accesscontrol/luasrc/view/mia/mia_status.htm

mv package/luci-app-tcpdump/po/zh-cn package/luci-app-tcpdump/po/zh_Hans
sed -i 's/Tcpdump 流量监控/流量捕获/g' package/luci-app-tcpdump/po/zh_Hans/tcpdump.po

sed -i 's/network/control/g' feeds/custom/luci-app-oaf/luasrc/controller/appfilter.lua
sed -i 's/network/control/g' feeds/custom/luci-app-oaf/luasrc/view/admin_network/user_status.htm

sed -i 's/network/control/g' feeds/custom/luci-app-eqos/luasrc/controller/eqos.lua
sed -i '/msgid "EQoS"/{n;s/IP限速/网速控制/;}' feeds/custom/luci-app-eqos/po/zh_Hans/eqos.po

sed -i 's/CPU 性能优化调节/CPU 调节/g' feeds/custom/luci-app-cpufreq/po/zh_Hans/cpufreq.po

sed -i 's/带宽监控/监控/g' feeds/custom/default-settings/po/zh_Hans/more.zh_Hans.po

sed -i 's/KMS 服务器/KMS 服务/g' feeds/custom/luci-app-vlmcsd/po/zh_Hans/vlmcsd.po

sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/controller/passwall.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/node_config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/node_list.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/node_subscribe.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/rule.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/client/shunt_rules.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/server/index.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/model/cbi/passwall/server/user.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/app_update/brook_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/app_update/kcptun_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/app_update/trojan_go_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/app_update/v2ray_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/global/footer.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/global/status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/global/status2.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/global/tips.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/haproxy/status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/log/log.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/node_list/link_add_node.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/node_list/link_share_man.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/node_list/node_list.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/rule/rule_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/server/log.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-passwall/luasrc/view/passwall/server/users_list_status.htm

sed -i 's/services/vpn/g' feeds/custom/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-jd-dailybonus/luasrc/view/jd-dailybonus/update_service.htm
sed -i 's/京东签到服务/京东签到/g' feeds/custom/luci-app-jd-dailybonus/po/zh_Hans/jd-dailybonus.po

sed -i 's/services/vpn/g' feeds/custom/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json
sed -i '/"title": "SmartDNS",/a\		"order": 3,' feeds/custom/luci-app-smartdns/root/usr/share/luci/menu.d/luci-app-smartdns.json

sed -i 's/services/vpn/g' feeds/custom/luci-app-koolproxyR/files/usr/lib/lua/luci/controller/koolproxy.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-koolproxyR/files/usr/lib/lua/luci/model/cbi/koolproxy/global.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-koolproxyR/files/usr/lib/lua/luci/model/cbi/koolproxy/rss_rule.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-koolproxyR/files/usr/lib/lua/luci/view/koolproxy/index.htm

sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/AdGuard Home/AdGuard/g' feeds/custom/luci-app-adguardhome/luasrc/controller/AdGuardHome.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/model/cbi/AdGuardHome/base.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/model/cbi/AdGuardHome/manual.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/view/AdGuardHome/AdGuardHome_check.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/view/AdGuardHome/AdGuardHome_status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/view/AdGuardHome/log.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-adguardhome/luasrc/view/AdGuardHome/yamleditor.htm

sed -i 's/Adblock Plus+/广告屏蔽/g' feeds/custom/luci-app-adblock-plus/luasrc/controller/adblock-plus.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adblock-plus/luasrc/controller/adblock-plus.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adblock-plus/luasrc/model/cbi/adblock-plus/base.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-adblock-plus/luasrc/view/adblock-plus/adblock_status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-adblock-plus/luasrc/view/adblock-plus/refresh.htm

sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/controller/openclash.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/client.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/config-subscribe-edit.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/config-subscribe.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/game-rules-manage.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/groups-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/log.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/proxy-provider-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/proxy-provider-file-manage.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-file-manage.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-manage.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/rule-providers-settings.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/servers-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/servers.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/model/cbi/openclash/settings.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/view/openclash/download_rule.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/view/openclash/server_list.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/view/openclash/status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/view/openclash/switch_mode.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-openclash/luasrc/view/openclash/update.htm

sed -i 's/"ShadowSocksR Plus+"/"畅游国际"/g' feeds/custom/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/server-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/server.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/servers.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/check.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/checkport.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/refresh.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/server_list.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-ssr-plus/luasrc/view/shadowsocksr/subscribe.htm
sed -i 's/ShadowSocksR Plus+ 设置/SSR Plus设置/g' feeds/custom/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
#echo -e "\nmsgid \"ShadowSocksR Plus+\"" >> feeds/custom/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po
#echo -e "msgstr \"SSR Plus\"" >> feeds/custom/luci-app-ssr-plus/po/zh_Hans/ssr-plus.po

sed -i 's/"Bypass"/"畅游国际"/g' feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/client-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/server-config.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/server.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/servers.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/check.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/checkport.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/kcptun_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/refresh.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/server_list.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/status.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/status_bottom.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/subscribe.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/trojan_go_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/v2ray_version.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-bypass/luasrc/view/bypass/xray_version.htm

sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/controller/serverchan.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/model/cbi/serverchan/advanced.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/model/cbi/serverchan/client.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/model/cbi/serverchan/log.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/model/cbi/serverchan/setting.lua
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/view/serverchan/log.htm
sed -i 's/services/vpn/g' feeds/custom/luci-app-serverchan/luasrc/view/serverchan/status.htm

