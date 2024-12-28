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
  git clone --depth=1 -b "${REPO_BRANCH}" "${REPO_URL}" "${CONFIG_REPO}" || {  
    echo "Failed to clone repository."  
    exit 1  
  }  
fi  

# root.  
export FORCE_UNSAFE_CONFIGURE=1  
pushd "${CONFIG_REPO}" || exit 1  
git pull || { echo "Failed to pull latest changes."; exit 1; }  

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

echo "Downloading packages..."  
make download -j8 V=s  

# 并行构建设置  
echo "开始编译${CONFIG_REPO}-${CONFIG_NAME}固件用 $(nproc) 线程..."  

# 设置错误日志路径
ERROR_LOG_NAME="${CONFIG_REPO}-${CONFIG_NAME}_make_error.log"  

# 执行make命令，若失败返回错误码1并记录错误日志路径  
(make -j$(nproc) V=s > make_output.log 2> "${ERROR_LOG_NAME}") || \
(make -j1 V=s >> make_output.log 2>> "${ERROR_LOG_NAME}")  

if [ $? -ne 0 ]; then  
  echo "BUILD_STATUS=failed" >> $GITHUB_ENV   # 失败时设置状态变量  
  echo "${CONFIG_REPO}-${CONFIG_NAME}固件构建失败!"  
  echo "${CONFIG_REPO}-${CONFIG_NAME}构建错误日志:"  
  cat "${ERROR_LOG_NAME}"  
  mv -f "${ERROR_LOG_NAME}" "${WORKSPACE}"  
  exit 1    
else  
  echo "BUILD_STATUS=success" >> $GITHUB_ENV  # 成功时设置状态变量  
  echo "${CONFIG_REPO}-${CONFIG_NAME}固件构建成功!"  
fi  
ls -al  

# 移动构建产物  
pushd bin/targets/*/* || exit 1  # 确保目录变更成功  
ls -al  
# 移动文件到工作空间  
if ls *combined*.img.gz 1> /dev/null 2>&1; then  
  mv -f *combined*.img.gz "${WORKSPACE}"  
else  
  echo "没有发现编译好的固件！"  
  exit 1  
fi  
popd || exit 1  # 确保返回成功  
popd || exit 1  # 确保返回成功  
du -chd1 "${CONFIG_REPO}"  
echo "完成"
