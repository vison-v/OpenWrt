#!/bin/bash

# 输出开始信息
echo "Starting to find subdirectories in feeds/vi and delete matching directories in feeds"

# 获取 feeds/vi 目录下的子目录名
find "feeds/vi" -maxdepth 1 -type d -printf '%f\0' | while IFS= read -r -d '' sub_dir; do
    echo "Processing subdirectory: $sub_dir"
    # 执行查找并删除操作
    #find "feeds" -depth -path "vi" -prune -o -type d -name "$sub_dir" -exec rm -rf {} +  
    find "feeds" -depth -path "feeds/vi" -prune -o -type d -name "$sub_dir" -print
    # 输出查找并删除操作完成信息
    echo "Finished processing subdirectory: $sub_dir"
done

# 输出结束信息
echo "Script execution completed."

