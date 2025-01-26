#!/bin/bash

# 输出开始信息
echo "开始在 feeds/vi 目录中查找子目录，并进行相应操作.................."

# 获取 feeds/vi 目录下的子目录名
find "feeds/vi" -maxdepth 1 -type d \( ! -name "vi" -a ! -name ".git" \) -printf '%f\0' | while IFS= read -r -d '' sub_dir; do
    echo "需要处理的目录为: $sub_dir"

    if [[ $sub_dir == luci-app-* ]]; then
        # 如果是 luci-app-* 目录，直接删除找到的同名目录
        find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | xargs -0 -I {} bash -c 'echo "删除: {}"; rm -rf {}'
    else
        # 对于非 luci-app-* 目录，进行替换操作
        find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | while IFS= read -r -d '' target_dir; do
            source_dir="feeds/vi/$sub_dir"
            if [ -d "$source_dir" ]; then
                # 创建临时目录
                temp_dir=$(mktemp -d)
                # 开启对隐藏文件的匹配
                shopt -s dotglob
                # 将源目录内容（包括隐藏文件）递归移动到临时目录
                mv "$source_dir/"* "$temp_dir/"
                # 关闭对隐藏文件的匹配
                shopt -u dotglob
                # 删除目标目录
                rm -rf "$target_dir"
                # 将临时目录内容移动到目标目录位置
                mv "$temp_dir" "$target_dir"
                echo "已将 $source_dir 替换到 $target_dir"
            else
                echo "源目录 $source_dir 不存在，跳过替换操作"
            fi
        done
        # 移动替换完成后，删除 feeds/vi 下的同名源目录
        source_dir="feeds/vi/$sub_dir"
        if [ -d "$source_dir" ]; then
            rm -rf "$source_dir"
            echo "已删除 feeds/vi 下的源目录 $source_dir"
        fi
    fi
    # 输出查找并操作完成信息
    echo "完成目录处理: $sub_dir"
done

# 输出结束信息
echo "脚本执行完毕."
