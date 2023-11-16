#!/bin/bash

# 指定输入文件夹和输出文件
input_folder="notes"
output_file="README.md"

# 检查输入文件夹是否存在
if [ ! -d "$input_folder" ]; then
  echo "错误：输入文件夹不存在！"
  exit 1
fi

# 清空输出文件
echo "# TIL" > "$output_file"
echo "> Today I Learned" >> "$output_file"

# create index
echo "### Categories" >> "$output_file"
for subfolder in "$input_folder"/*; do
  # 检查是否为子文件夹
  if [ -d "$subfolder" ]; then
    # 输出子文件夹标题到输出文件
    subfoldername=$(basename "$subfolder")
    echo "- ["$subfoldername"](#"$subfoldername")" >> "$output_file"
  fi
done

echo "---" >> "$output_file"

# 循环读取文件夹中的子文件夹
for subfolder in "$input_folder"/*; do
  # 检查是否为子文件夹
  if [ -d "$subfolder" ]; then
    # 输出子文件夹标题到输出文件
    subfoldername=$(basename "$subfolder")
    echo "### "$subfoldername"" >> "$output_file"
    
    # 循环读取子文件夹中的文件
    for file in "$subfolder"/*; do
      # 检查是否为文件
      if [ -f "$file" ]; then
        # 输出文件名到输出文件
	filefull=$(basename -- "$file")
	filename="${filefull%.*}"
        listname=$(echo $filename | tr '-' ' ')
	listname=$(echo $listname | tr '_' ' ')
	listname=$(echo $listname | sed 's/\b\(.\)/\u\1/g')
	echo "- ["$listname"](notes/"$subfoldername"/"$filefull")" >> "$output_file"
      fi
    done
    
    # 添加空行
    echo -e "\n" >> "$output_file"
  fi
done

echo "Congratulations to your progress!"
echo "Done! output file：$output_file"

