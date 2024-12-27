#!/usr/bin/env bash  

# Copyright (C) 2022 Ing <https://github.com/wjz304>  
# This is free software, licensed under the MIT License.  
# See /LICENSE for more information.  

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

# 检查config文件命名是否正确，若不正确退出  
if [ ${#CONFIG_ARRAY[@]} -ne 3 ]; then  
  echo "${config_path} name error!"     # config命名规则: <repo>;<owner>;<name>.config  
  exit 1   
fi  

CONFIG_REPO="${CONFIG_ARRAY[0]}"  
CONFIG_OWNER="${CONFIG_ARRAY[1]}"  
CONFIG_NAME="${CONFIG_ARRAY[2]}"  

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
    echo "${config_path} name error!"  
    exit 1  
    ;;  
esac  

# 克隆或更新仓库  
if [ ! -d "${CONFIG_REPO}" ]; then    
  git clone --depth=1 -b "${REPO_BRANCH}" "${REPO_URL}" "${CONFIG_REPO}"  
fi  

# root.  
export FORCE_UNSAFE_CONFIGURE=1  
pushd "${CONFIG_REPO}" || exit 1  
git pull  
sed -i "/src-git vi /d; 1 i src-git vi https://github.com/vison-v/packages;${CONFIG_REPO}" feeds.conf.default  
./scripts/feeds update -a  
./scripts/feeds install -a  
./scripts/feeds uninstall $(grep Package ./feeds/vi.index | awk -F': ' '{print $2}')  
./scripts/feeds install -p vi -a  
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
echo "Starting compilation for ${CONFIG_REPO}-${CONFIG_NAME} with $(nproc) threads..."  

# 设置错误日志路径并写入 GITHUB_ENV  
ERROR_LOG_PATH="${CONFIG_REPO}-${CONFIG_NAME}_make_error.log"  
echo "ERROR_LOG_PATH=${ERROR_LOG_PATH}" >> $GITHUB_ENV  

# 执行make命令，若失败返回错误码1并记录错误日志路径  
(make -j$(nproc) V=s > make_output.log 2> "${ERROR_LOG_PATH}") || \
(make -j1 V=s >> make_output.log 2>> "${ERROR_LOG_PATH}")  

if [ $? -ne 0 ]; then  
  echo "Build failed for ${CONFIG_REPO}-${CONFIG_NAME}!"  
  echo "${CONFIG_REPO}-${CONFIG_NAME} error log:"  
  cat "${ERROR_LOG_PATH}"  
  exit 1    
else  
  echo "Build succeeded for ${CONFIG_REPO}-${CONFIG_NAME}!"  
fi

# 移动构建产物  
pushd bin/targets/*/* || exit 1  
ls -al  
# 移动文件到工作空间  
mv -f *combined*.img.gz "${WORKSPACE}"  
popd || exit 1  
popd || exit 1  
du -chd1 "${CONFIG_REPO}"  
echo "Done"
