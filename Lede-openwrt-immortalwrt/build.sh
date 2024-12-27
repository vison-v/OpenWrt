#!/usr/bin/env bash  
#  
# Copyright (C) 2022 Ing <https://github.com/wjz304>  
#  
# This is free software, licensed under the MIT License.  
# See /LICENSE for more information.  
#  

if [ -z "${1}" ] || [ ! -f "${1}" ]; then  
  echo "Usage: $0 <config file>"  
  exit 1  
fi  

WORKSPACE="$(pwd)"  

script_path=$(realpath "$(dirname "${1}")/custom.sh")  
config_path=$(realpath "${1}")               # 绝对路径  
CONFIG_FNAME=$(basename "${1}" .config) # 取文件名  
CONFIG_ARRAY=(${CONFIG_FNAME//;/ })     # 分割成数组  

if [ ${#CONFIG_ARRAY[@]} -ne 3 ]; then  
  echo "${config_path} name error!" # config命名规则: <repo>;<owner>;<name>.config  
  exit 1  
fi  

CONFIG_REPO="${CONFIG_ARRAY[0]}"  
CONFIG_OWNER="${CONFIG_ARRAY[1]}"  
CONFIG_NAME="${CONFIG_ARRAY[2]}"  

if [ "${CONFIG_REPO}" = "openwrt" ]; then  
  REPO_URL="https://github.com/openwrt/openwrt"  
  REPO_BRANCH="master"  
elif [ "${CONFIG_REPO}" = "lede" ]; then  
  REPO_URL="https://github.com/coolsnowwolf/lede"  
  REPO_BRANCH="master"  
elif [ "${CONFIG_REPO}" = "immortalwrt" ]; then  
  REPO_URL="https://github.com/immortalwrt/immortalwrt"  
  REPO_BRANCH="openwrt-23.05"  
else  
  echo "${config_path} name error!"  
  exit 1  
fi  

if [ ! -d "${CONFIG_REPO}" ]; then  
  git clone --depth=1 -b "${REPO_BRANCH}" "${REPO_URL}" "${CONFIG_REPO}"  
fi  

# root.  
export FORCE_UNSAFE_CONFIGURE=1  
pushd "${CONFIG_REPO}"  

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

if [ "$GITHUB_ACTIONS" = "true" ]; then  
  pushd "${GITHUB_WORKSPACE}"  
  git pull  
  cp -f "${WORKSPACE}/${CONFIG_REPO}/.config" "${GITHUB_WORKSPACE}/Lede-openwrt-immortalwrt/${config}"  
  status=$(git status -s | grep "${CONFIG_FNAME}" | awk '{printf $2}')  
  if [ -n "${status}" ]; then  
    git add "${status}"  
    git commit -m "update $(date +%Y-%m-%d" "%H:%M:%S)"  
    git push -f  
  fi  
  popd  
fi  

echo "Downloading packages..."  
make download -j8 V=s  

# Parallel build setup  
pids=()  # 用于存储进程ID  

echo "Starting compilation for ${CONFIG_REPO} with $(nproc) threads..."  
{  
    (make -j$(nproc) V=s > make_output.log 2> ${CONFIG_REPO}_${CONFIG_NAME}_make_error.log) || \
    (make -j1 V=s >> make_output.log 2>> ${CONFIG_REPO}_${CONFIG_NAME}_make_error.log)  

    if [ $? -ne 0 ]; then  
        echo "Build failed for ${CONFIG_REPO}!"  
        echo "${CONFIG_REPO}_${CONFIG_NAME}_make_error log:"  
        cat ${CONFIG_REPO}_${CONFIG_NAME}_make_error.log  
        echo "Continuing with other branches..."  
    else  
        echo "Build succeeded for ${CONFIG_REPO}!"  
    fi  
} &  # 将构建过程放入后台  

pids+=($!)  # 保存后台进程的ID  

# 等待所有构建进程完成  
for pid in "${pids[@]}"; do  
    wait "$pid"  
done  

# 然后移动构建产物  
pushd bin/targets/*/*  

ls -al  

# mv -f *combined*.img.gz "${WORKSPACE}"  

# 移动文件到工作空间  
mv -f *combined*.img.gz "${WORKSPACE}"  

popd # bin/targets/*/*  

popd # ${CONFIG_REPO}  

du -chd1 "${CONFIG_REPO}"  

echo "Done"
