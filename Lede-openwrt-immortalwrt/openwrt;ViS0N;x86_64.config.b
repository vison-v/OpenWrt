CONFIG_SIGNATURE_CHECK=n
CONFIG_TARGET_ROOTFS_EXT4FS=n
CONFIG_LUCI_CSSTIDY=n
CONFIG_GRUB_CONSOLE=n
CONFIG_BUILD_PATENTED=y
CONFIG_GRUB_TIMEOUT="0"
CONFIG_GRUB_BOOTOPTS="nomodeset"

# 设置固件大小:
CONFIG_TARGET_KERNEL_PARTSIZE=30
CONFIG_TARGET_ROOTFS_PARTSIZE=300

CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y

# EFI支持:
CONFIG_GRUB_IMAGES=n
CONFIG_EFI_IMAGES=y
CONFIG_VMDK_IMAGES=n
CONFIG_ISO_IMAGES=n
CONFIG_TARGET_ROOTFS_TARGZ=n

# 打开适用于VMware的VM Tools:
CONFIG_PACKAGE_open-vm-tools=y

# 打开适用于PVE的qemu-guest-agent:
# CONFIG_PACKAGE_qemu-ga=y

# IPv6支持:
CONFIG_IPV6=y
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
CONFIG_PACKAGE_ipv6helper=y

# USB3.0支持:
CONFIG_PACKAGE_kmod-usb2=y
CONFIG_PACKAGE_kmod-usb2-pci=y
CONFIG_PACKAGE_kmod-usb3=y
CONFIG_PACKAGE_kmod-usb-ohci-pci=y
CONFIG_PACKAGE_kmod-usb-ohci=y

# 固件压缩:
CONFIG_TARGET_IMAGES_GZIP=y

# 中文支持:
CONFIG_PACKAGE_default-settings-chn=y

# 加载插件
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-minidlna=y
CONFIG_PACKAGE_luci-app-wechatpush=y
CONFIG_PACKAGE_luci-app-syncdial=y
CONFIG_PACKAGE_luci-app-usb-printer=y
CONFIG_PACKAGE_luci-app-hd-idle=y
CONFIG_PACKAGE_luci-app-oaf=y
CONFIG_PACKAGE_luci-app-tcpdump=y
CONFIG_PACKAGE_luci-app-control-weburl=y
CONFIG_PACKAGE_luci-app-control-timewol=y
CONFIG_PACKAGE_luci-app-control-webrestriction=y
CONFIG_PACKAGE_luci-app-eqosplus=y
#CONFIG_PACKAGE_luci-app-socat=y
CONFIG_PACKAGE_luci-app-cifs-mount=y
#CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-app-watchcat=y
CONFIG_PACKAGE_luci-app-unblockneteasemusic=y
CONFIG_PACKAGE_luci-app-wrtbwmon=y
CONFIG_PACKAGE_luci-app-smartdns=y

# LuCI主题:
CONFIG_PACKAGE_luci-app-argon-config=y

# 你好，世界
# CONFIG_PACKAGE_luci-app-bypass=y
CONFIG_PACKAGE_luci-app-passwall=y
# CONFIG_PACKAGE_luci-app-openclash=y
# CONFIG_PACKAGE_luci-app-ssr-plus=y
