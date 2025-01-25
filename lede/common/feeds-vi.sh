#!/bin/bash

# 输出开始信息
echo "Starting to find subdirectories in feeds/vi and delete matching directories in feeds"

# 获取 feeds/vi 目录下的子目录名
find "feeds/vi" -maxdepth 1 -type d \( ! -name "vi" -a ! -name ".git" \) -printf '%f\0' | while IFS= read -r -d '' sub_dir; do
    echo "需要处理的目录为: $sub_dir"
    # 查找深度 4 级以内且符合条件的同名目录
    find "feeds" -maxdepth 4 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | while IFS= read -r -d '' target_dir; do
        source_dir="feeds/vi/$sub_dir"
        if [ -d "$source_dir" ]; then
            # 创建临时目录
            temp_dir=$(mktemp -d)
            # 复制源目录内容到临时目录
            cp -r "$source_dir/" "$temp_dir/"
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

