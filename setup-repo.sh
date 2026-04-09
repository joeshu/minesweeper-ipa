#!/bin/bash

# 扫雷 iOS 项目 GitHub 仓库设置脚本

set -e

echo "=========================================="
echo "  Minesweeper iOS - GitHub 设置脚本"
echo "=========================================="
echo ""

# 检查是否提供了 GitHub 用户名
if [ -z "$1" ]; then
    echo "使用方法: ./setup-repo.sh <GitHub用户名> [仓库名]"
    echo ""
    echo "示例:"
    echo "  ./setup-repo.sh joeshu"
    echo "  ./setup-repo.sh joeshu minesweeper-ipa"
    echo ""
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME=${2:-"minesweeper-ipa"}

echo "GitHub 用户名: $GITHUB_USERNAME"
echo "仓库名称: $REPO_NAME"
echo ""

# 检查 git 是否安装
if ! command -v git &> /dev/null; then
    echo "错误: 未找到 git，请先安装 git"
    exit 1
fi

# 检查当前目录是否是项目根目录
if [ ! -f "Minesweeper.xcodeproj/project.pbxproj" ]; then
    echo "错误: 请在项目根目录运行此脚本"
    echo "当前目录: $(pwd)"
    exit 1
fi

echo "步骤 1/5: 初始化 Git 仓库..."
if [ -d ".git" ]; then
    echo "  Git 仓库已存在，跳过初始化"
else
    git init
    echo "  ✓ Git 仓库初始化完成"
fi

echo ""
echo "步骤 2/5: 添加文件到 Git..."
git add .
echo "  ✓ 文件添加完成"

echo ""
echo "步骤 3/5: 提交更改..."
git commit -m "Initial commit: Optimized Minesweeper iOS app with GitHub Actions" || echo "  已提交，跳过"
echo "  ✓ 提交完成"

echo ""
echo "步骤 4/5: 添加远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
echo "  ✓ 远程仓库添加完成"
echo "     URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo ""
echo "步骤 5/5: 推送到 GitHub..."
echo "  正在推送到 main 分支..."

# 尝试推送
if git push -u origin main 2>/dev/null; then
    echo "  ✓ 推送完成"
elif git push -u origin master 2>/dev/null; then
    echo "  ✓ 推送完成 (master 分支)"
else
    echo ""
    echo "  ⚠️  推送失败，请检查:"
    echo "     1. 是否已在 GitHub 创建仓库: https://github.com/new"
    echo "     2. 仓库名称是否正确: $REPO_NAME"
    echo "     3. 是否有推送权限"
    echo ""
    echo "  手动推送命令:"
    echo "     git push -u origin main"
    exit 1
fi

echo ""
echo "=========================================="
echo "  ✅ 设置完成！"
echo "=========================================="
echo ""
echo "项目地址:"
echo "  https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""
echo "下一步:"
echo "  1. 访问 Actions 页面启用工作流:"
echo "     https://github.com/$GITHUB_USERNAME/$REPO_NAME/actions"
echo ""
echo "  2. 点击 'I understand my workflows, go ahead and enable them'"
echo ""
echo "  3. 推送代码触发构建，或手动触发:"
echo "     - 访问 Actions 页面"
echo "     - 选择 'Build IPA'"
echo "     - 点击 'Run workflow'"
echo ""
echo "  4. 下载构建好的 IPA 文件"
echo ""
echo "感谢使用！🎮"
echo ""
