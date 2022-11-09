#!/bin/bash 
rm -Rf feeds/luci/applications/{luci-app-aliyundrive-webdav,luci-app-aliyundrive-fuse,luci-app-appfilter,luci-app-bypass,luci-app-adguardhome,luci-app-koolproxyR}
##############加载自定义app################
git clone https://github.com/sirpdboy/luci-app-wizard.git package/openwrt-packages/luci-app-wizard
git clone https://github.com/KFERMercer/luci-app-tcpdump.git package/openwrt-packages/luci-app-tcpdump
git clone https://github.com/destan19/OpenAppFilter.git package/openwrt-packages/OpenAppFilter
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/openwrt-packages/luci-app-koolproxyR
git clone https://github.com/kiddin9/luci-app-dnsfilter package/openwrt-packages/luci-app-dnsfilter
svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/openwrt-packages/luci-app-bypass
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/openwrt-packages/luci-app-adguardhome
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav package/openwrt-packages/luci-app-aliyundrive-webdav
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-fuse package/openwrt-packages/luci-app-aliyundrive-fuse

##############菜单整理美化#################
./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/tty\(0\|1\)::askfirst/tty\1::respawn/g" target/linux/*/base-files/etc/inittab

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/%D %V, %C/%D %V, %C, Build By ViS0N/g' package/base-files/files/etc/banner

sed -i 's/msgstr "主机名映射"/msgstr "主机映射"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i 's/msgstr "备份与升级"/msgstr "备份升级"/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Administration"/{n;s/管理权/权限管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Software"/{n;s/软件包/软件管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Startup"/{n;s/启动项/启动管理/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Mount Points"/{n;s/挂载点/挂载路径/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "Reboot"/{n;s/"重启"/"立即重启"/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po
sed -i '/msgid "VPN"/{n;s/VPN/酷软/;}' feeds/luci/modules/luci-base/po/zh_Hans/base.po

sed -i '/msgid "Reboot"/{n;s/"重启"/"立即重启"/;}' feeds/luci/applications/luci-app-advanced-reboot/po/zh_Hans/advanced-reboot.po

echo -e "\nmsgid \"Control\"" >> package/emortal/default-settings/i18n/default.zh_Hans.po
echo -e "msgstr \"管控\"" >> package/emortal/default-settings/i18n/default.zh_Hans.po

sed -i 's/msgstr "网络存储"/msgstr "存储"/g' package/emortal/default-settings/i18n/default.zh_Hans.po
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' feeds/luci/applications/luci-app-vsftpd/po/zh_Hans/vsftpd.po
sed -i 's/msgstr "网络存储"/msgstr "存储"/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po

#sed -i '/localtime  = os.date()/s/()/("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
#sed -i '/local cpu_usage/a\\t\tlocal up_time = luci.sys.exec("cntime")' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
#sed -i "s/String.format('%t', info.uptime)/info.uptime/" package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
#sed -i 's/= sysinfo.uptime or 0/= up_time/' package/lean/autocore/files/x86/index.htm package/lean/autocore/files/arm/index.htm
sed -i '/$(INSTALL_DIR) $(1)\/sbin/a\\t$(INSTALL_BIN) .\/files\/generic\/cntime $(1)\/sbin\/cntime' package/emortal/autocore/Makefile

sed -i 's/40)./45)./g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/dockerman.lua
sed -i 's/msgstr "Docker"/msgstr "容器"/g' feeds/luci/applications/luci-app-dockerman/po/zh_Hans/dockerman.po

sed -i 's/44/43/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-usb-printer/luasrc/controller/usb_printer.lua
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po
sed -i 's/USB 打印服务器/打印服务/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/luci-app-usb-printer.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-usb-printer/po/zh_Hans/usb-printer.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-minidlna/root/usr/share/luci/menu.d/luci-app-minidlna.json
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-hd-idle/root/usr/share/luci/menu.d/luci-app-hd-idle.json
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-samba4/root/usr/share/luci/menu.d/luci-app-samba4.json

sed -i '/"title": "Terminal",/a\		"order": 47,' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/services/system/g' feeds/luci/applications/luci-app-ttyd/root/usr/share/luci/menu.d/luci-app-ttyd.json
sed -i 's/msgstr "终端"/msgstr "命令终端"/g' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po

sed -i 's/IP\/MAC 绑定/地址绑定/g' feeds/luci/applications/luci-app-arpbind/po/zh_Hans/arpbind.po

sed -i '/msgid "ZeroTier"/{n;s/msgstr ""/msgstr "内网穿透"/;}' feeds/luci/applications/luci-app-zerotier/po/zh_Hans/zerotier.po

sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-diag-core/po/zh_Hans/diag_core.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' package/emortal/default-settings/i18n/more.zh_Hans.po
sed -i 's/msgstr "诊断"/msgstr "网络诊断"/g' feeds/luci/applications/luci-app-mwan3/po/zh_Hans/mwan3.po

sed -i 's/msgstr "Socat"/msgstr "端口转发"/g' feeds/luci/applications/luci-app-socat/po/zh_Hans/socat.po

sed -i 's/msgstr "软件包"/msgstr "软件管理"/g' feeds/luci/applications/luci-app-opkg/po/zh_Hans/opkg.po

sed -i 's/BaiduPCS Web/百度网盘/g' feeds/luci/applications/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua

sed -i 's/"Inital Setup"/"向导"/g' package/openwrt-packages/luci-app-wizard/files/luci/controller/wizard.lua
sed -i "s/lan_ipaddr '*.*.*.*'/lan_ipaddr '192.168.10.1'/g" package/openwrt-packages/luci-app-wizard/files/root/etc/config/wizard

sed -i 's/Setting/其它设置/g' feeds/luci/applications/luci-app-netdata/luasrc/controller/netdata.lua

echo -e "\nmsgid \"qBittorrent\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po
echo -e "msgstr \"BT  下载\"" >> feeds/luci/applications/luci-app-qbittorrent/po/zh_Hans/qbittorrent.po
sed -i 's/+qBittorrent/+qBittorrent-Enhanced-Edition/g' feeds/luci/applications/luci-app-qbittorrent/Makefile

sed -i 's/aMule设置/电驴下载/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po
sed -i 's/网络存储/存储/g' feeds/luci/applications/luci-app-amule/po/zh_Hans/amule.po

sed -i 's/可道云/可道云盘/g' feeds/luci/applications/luci-app-kodexplorer/po/zh_Hans/kodexplorer.po

sed -i 's/88/89/g' feeds/luci/applications/luci-app-autoreboot/luasrc/controller/autoreboot.lua

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-cifs-mount/luasrc/controller/cifs.lua
sed -i 's/"挂载 SMB 网络共享"/"挂载 SMB"/g' feeds/luci/applications/luci-app-cifs-mount/po/zh_Hans/cifs.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/NAS/Services/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
sed -i 's/msgstr "Rclone"/msgstr "挂载网盘"/g' feeds/luci/applications/luci-app-rclone/po/zh_Hans/luci-app-rclone.po

sed -i 's/nas/services/g' feeds/luci/applications/luci-app-nfs/luasrc/controller/nfs.lua

sed -i 's/89/88/g' feeds/luci/applications/luci-app-filetransfer/luasrc/controller/filetransfer.lua

sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh_Hans/turboacc.po

sed -i 's/解锁网易云灰色歌曲/网易音乐/g' feeds/luci/applications/luci-app-unblockmusic/po/zh_Hans/unblockmusic.po
sed -i 's/services/vpn/g'  `grep services -rl feeds/luci/applications/luci-app-unblockmusic/luasrc`
sed -i 's/解除网易云音乐播放限制/网易音乐/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json

sed -i 's/AliyunDrive WebDAV/阿里云盘/g' package/openwrt-packages/luci-app-aliyundrive-webdav/luasrc/controller/aliyundrive-webdav.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-aliyundrive-webdav/luasrc`

sed -i 's/AliyunDrive FUSE/云盘FUSE/g' package/openwrt-packages/luci-app-aliyundrive-fuse/luasrc/controller/aliyundrive-fuse.lua
sed -i 's/services/vpn/g'  `grep services -rl package/openwrt-packages/luci-app-aliyundrive-fuse/luasrc`

sed -i '/msgid "UU GameAcc"/{n;s/UU游戏加速器/UU加速器/;}' feeds/luci/applications/luci-app-uugamebooster/po/zh_Hans/uugamebooster.po

sed -i 's/上网时间控制/时间控制/g' feeds/luci/applications/luci-app-timecontrol/po/zh_Hans/timecontrol.po

sed -i 's/上网时间控制/时间控制/g' feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po
sed -i 's/services/control/g'  `grep services -rl feeds/luci/applications/luci-app-accesscontrol/luasrc`

sed -i 's/Tcpdump 流量监控/流量监控/g' package/openwrt-packages/luci-app-tcpdump/po/zh-cn/tcpdump.po

sed -i 's/services/control/g'  `grep network -rl package/openwrt-packages/OpenAppFilter/luci-app-oaf/luasrc`

sed -i 's/90/56/g' feeds/luci/applications/luci-app-argon-config/luasrc/controller/argon-config.lua
sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/luci/applications/luci-app-argon-config/po/zh_Hans/argon-config.po

sed -i 's/network/control/g'  `grep network -rl feeds/luci/applications/luci-app-eqos/luasrc`
sed -i '/msgid "EQoS"/{n;s/IP限速/网速控制/;}' feeds/luci/applications/luci-app-eqos/po/zh_Hans/eqos.po

sed -i 's/CPU 性能优化调节/CPU 调节/g' feeds/luci/applications/luci-app-cpufreq/po/zh_Hans/cpufreq.po
