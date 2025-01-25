#!/bin/bash

# 输出开始信息
echo "开始在 feeds/vi 目录中查找子目录，并替换 feeds 目录中匹配的目录.................."

# 获取 feeds/vi 目录下的子目录名
find "feeds/vi" -maxdepth 1 -type d \( ! -name "vi" -a ! -name ".git" \) -printf '%f\0' | while IFS= read -r -d '' sub_dir; do
    echo "需要处理的目录为: $sub_dir"
    find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | while IFS= read -r -d '' target_dir; do
        source_dir="feeds/vi/$sub_dir"
        if [ -d "$source_dir" ]; then
            # 创建临时目录
            temp_dir=$(mktemp -d)
            # 将源目录内容递归移动到临时目录
            mv "$source_dir/"* "$temp_dir/"
            # 删除目标目录
            rm -rf "$target_dir"
            # 将临时目录内容移动到目标目录位置
            mv "$temp_dir" "$target_dir"
            echo "已将 $source_dir 替换到 $target_dir"
        else
            echo "源目录 $source_dir 不存在，跳过替换操作"
        fi
    done
    echo "完成目录处理: $sub_dir"
done

# 输出结束信息
echo "脚本执行完毕."

