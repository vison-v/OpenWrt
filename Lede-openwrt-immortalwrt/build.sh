#!/usr/bin/env bash  

# Copyright (C) 2022 Ing <https://github.com/wjz304>  
# This is free software, licensed under the MIT License.  
# See /LICENSE for more information.  

set -e  # Exit immediately if a command exits with a non-zero status.  

# 检查参数是否正确  
if [ -z "${1}" ] || [ ! -f "${1}" ]; then  
  echo "Usage: $0 <config file>"  
  exit 1  
fi  

WORKSPACE="$(pwd)"  
script_path=$(realpath "$(dirname "${1}")/custom.sh")  
config_path=$(realpath "${1}")          # 绝对路径  
CONFIG_FNAME=$(basename "${1}" .config) # 取文件名  
CONFIG_ARRAY=(${CONFIG_FNAME//;/ })     # 分割成数组  

# 分割配置文件名
CONFIG_REPO="${CONFIG_ARRAY[0]}"  
CONFIG_OWNER="${CONFIG_ARRAY[1]}"  
CONFIG_NAME="${CONFIG_ARRAY[2]}"  

# 检查config文件命名是否正确，若不正确退出  
if [ -z "${CONFIG_REPO}" ] || [ -z "${CONFIG_OWNER}" ] || [ -z "${CONFIG_NAME}" ]; then  
  echo "${config_path}配置文件错误!"     # config命名规则: <repo>;<owner>;<name>.config  
  exit 1   
fi  

# 根据CONFIG_REPO设置REPO_URL和REPO_BRANCH，若不识别退出  
case "${CONFIG_REPO}" in  
  "openwrt")  
    REPO_URL="https://github.com/openwrt/openwrt"  
    REPO_BRANCH="master"  
    ;;  
  "lede")  
    REPO_URL="https://github.com/coolsnowwolf/lede"  
    REPO_BRANCH="master"  
    ;;  
  "immortalwrt")  
    REPO_URL="https://github.com/immortalwrt/immortalwrt"  
    REPO_BRANCH="openwrt-23.05"  
    ;;  
  *)  
    echo "${config_path}配置文件错误!"  
    exit 1  
    ;;  
esac  

# 克隆或更新仓库  
if [ ! -d "${CONFIG_REPO}" ]; then    
  git clone --depth=1 -b "${REPO_BRANCH}" "${REPO_URL}" "openwrt" || {  
    echo "克隆仓库失败！"  
    exit 1  
  }  
fi  

# root.  
export FORCE_UNSAFE_CONFIGURE=1  
pushd openwrt || exit 1  
git pull || { echo "未能拉取最新更改！"; exit 1; }  

# Update feeds and install packages  
sed -i "/src-git vi /d; 1 i src-git vi https://github.com/vison-v/packages;${CONFIG_REPO}" feeds.conf.default  
./scripts/feeds update -a  
./scripts/feeds install -a  
./scripts/feeds uninstall $(grep Package ./feeds/vi.index | awk -F': ' '{print $2}')  
./scripts/feeds install -p vi -a  

# Handle .config file  
if [ -f "./.config" ]; then  
    cat "${config_path}" >> "./.config"  
else  
    cp -f "${config_path}" "./.config"  
fi  

cp -f "${script_path}" "./custom.sh"  
chmod +x "./custom.sh"  
"./custom.sh" "${CONFIG_REPO}" "${CONFIG_OWNER}"  
make defconfig  

# 在GitHub Actions环境中处理配置文件更新  
if [ "$GITHUB_ACTIONS" = "true" ]; then  
  pushd "${GITHUB_WORKSPACE}" || exit 1  
  git pull  
  cp -f "${WORKSPACE}/${CONFIG_REPO}/.config" "${GITHUB_WORKSPACE}/Lede-openwrt-immortalwrt/${CONFIG_FNAME}.config"    
  status=$(git status -s | grep "${CONFIG_FNAME}" | awk '{printf $2}')  
  if [ -n "${status}" ]; then  
    git add "${status}"  
    git commit -m "update $(date +'%Y-%m-%d %H:%M:%S')"    
    git push -f  
  fi  
  popd || exit 1  
fi  

echo "下载packages..."  
make download -j8 V=s  
popd || exit 1  # 确保返回成功  
