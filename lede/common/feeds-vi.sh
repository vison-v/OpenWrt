#!/bin/bash

# 输出开始信息
echo "开始在 feeds/vi 目录中查找子目录，并删除 feeds 目录中匹配的目录.................."

# 获取 feeds/vi 目录下的子目录名
find "feeds/vi" -maxdepth 1 -type d \( ! -name "vi" -a ! -name ".git" \) -printf '%f\0' | while IFS= read -r -d '' sub_dir; do
    echo "需要处理的目录为: $sub_dir"
    # 执行查找并删除操作
    find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | xargs -0 -I {} bash -c 'echo "删除: {}"; rm -rf {}'
    # 输出查找并删除操作完成信息
    echo "完成目录处理: $sub_dir"
done

# 输出结束信息
echo "脚本执行完毕."

