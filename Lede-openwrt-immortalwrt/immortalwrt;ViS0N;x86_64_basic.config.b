CONFIG_SIGNATURE_CHECK=n
CONFIG_TARGET_ROOTFS_EXT4FS=n
CONFIG_LUCI_CSSTIDY=n
CONFIG_GRUB_CONSOLE=n
CONFIG_BUILD_PATENTED=y
CONFIG_GRUB_TIMEOUT="0"
CONFIG_GRUB_BOOTOPTS="nomodeset"

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

# Applications
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-minidlna=y
CONFIG_PACKAGE_luci-app-syncdial=y
CONFIG_PACKAGE_luci-app-usb-printer=y
CONFIG_PACKAGE_luci-app-hd-idle=y
CONFIG_PACKAGE_luci-app-socat=y
CONFIG_PACKAGE_luci-app-cifs-mount=y

# 关闭默认插件/主题
# CONFIG_PACKAGE_luci-app-xlnetacc is not set
# CONFIG_PACKAGE_luci-app-sqm is not set
# CONFIG_PACKAGE_luci-app-vsftpd is not set
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set
# CONFIG_PACKAGE_luci-app-ramfree is not set
# CONFIG_PACKAGE_luci-app-airplay2 is not set
# CONFIG_PACKAGE_luci-app-music-remote-center is not set
# CONFIG_PACKAGE_luci-app-webadmin is not set
# CONFIG_PACKAGE_luci-app-autoreboot is not set
# CONFIG_PACKAGE_luci-app-wireguard is not set
# CONFIG_PACKAGE_luci-app-adbyby-plus is not set
# CONFIG_PACKAGE_luci-app-ssr-plus is not set
# CONFIG_PACKAGE_luci-app-arpbind is not set
# CONFIG_PACKAGE_luci-app-accesscontrol is not set

# LuCI主题:
CONFIG_PACKAGE_luci-app-argon-config=y

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
