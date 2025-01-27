#!/bin/bash  

echo "开始在 feeds/vi 目录中查找子目录，并进行相应操作.................."  

find "feeds/vi" -maxdepth 1 -type d '(' ! -name "vi" -a ! -name ".git" ')' -printf '%f\0' | while IFS= read -r -d '' sub_dir; do  
    echo "需要处理的目录为: $sub_dir"  

    if [[ $sub_dir == luci-app-* ]]; then  
        find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | xargs -0 -I {} bash -c 'echo "删除: {}"; rm -rf {} || echo "删除失败: {}"'  
    else  
        find "feeds" -maxdepth 3 -type d -name "$sub_dir" ! -path "feeds/vi*" -print0 | while IFS= read -r -d '' target_dir; do  
            source_dir="feeds/vi/$sub_dir"  
            if [ -d "$source_dir" ]; then  
                if rm -rf "$target_dir" 2>/dev/null; then  
                    if mv "$source_dir" "$target_dir" 2>/dev/null; then  
                        rm -rf "$source_dir" && echo "已将 $source_dir 替换到 $target_dir 同时删除 $source_dir"  
                    else  
                        echo "移动 $source_dir 到 $target_dir 失败"  
                    fi  
                else  
                    echo "删除目标目录 $target_dir 失败"  
                fi  
            else  
                echo "源目录 $source_dir 不存在，跳过替换操作"  
            fi  
        done  
    fi  
    echo "完成目录处理: $sub_dir"  
done  

echo "脚本执行完毕."
