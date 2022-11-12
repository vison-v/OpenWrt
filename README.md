## 自动编译
![Openwrt-AutoBuild-Lean](https://github.com/vison-v/OpenWrt/workflows/Openwrt-AutoBuild-Lean/badge.svg)
![Openwrt-AutoBuild-Immortalwrt](https://github.com/vison-v/OpenWrt/workflows/Openwrt-AutoBuild-Immortalwrt/badge.svg)
![Merge-upstream](https://github.com/vison-v/OpenWrt/workflows/Merge-upstream/badge.svg)

    # 每天自动编译Lean x86-64固件，同步使用上游最新源码！
    # 如需同时编译多个固件，需要两个步骤：
       1.在Lean文件夹下放置配置文件夹（可参考AC58U或x86_64文件夹）
       2.同时修改Openwrt-AutoBuild-Lean.yml文件的44行为：target: [x86_64,配置文件夹名字]
    # 固件默认地址：192.168.10.1
    # 固件默认用户：root
    # 固件默认密码：password
 
 
## 插件截图 
![xm1](Pic/状态.png)
![xm2](Pic/插件.png)

## 参考感谢

    # 固件默认使用Lean为上游源码编译！Lean仓库地址：https://github.com/coolsnowwolf/lede
    # 增减插件需自行修改Lean/common/common.sh和Lean/common/config.diff文件
    # 插件都为网上寻找，插件作者可在Lean/common/common.sh文件中查看，在此表示感谢！
    # 固件主要个人使用，不提供任何技术支持和解答！
    ![Openwrt-AutoBuild-Immortalwrt](https://github.com/vison-v/OpenWrt/workflows/Openwrt-AutoBuild-Immortalwrt/badge.svg)
 
