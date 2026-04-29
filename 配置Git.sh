#!/bin/bash
echo "配置Git..."
read -p "请输入Git用户名: " git_name
read -p "请输入Git邮箱: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "nano"
git config --global init.defaultBranch "main"
git config --global pull.rebase false

echo "✅ Git配置完成"
echo "用户名: $git_name"
echo "邮箱: $git_email"
