#!/bin/bash

# 科研合伙人监控面板自动运行安装脚本
# 作者：刘亦菲 (科研合伙人)
# 功能：安装定时任务，每天早上9点和下午5点自动打开监控面板

echo "=========================================="
echo "科研合伙人监控面板自动运行安装程序"
echo "作者：刘亦菲 (科研合伙人)"
echo "=========================================="
echo ""

# 检查是否以管理员身份运行
if [ "$EUID" -ne 0 ]; then 
    echo "⚠️  需要管理员权限，请输入密码："
    sudo "$0" "$@"
    exit $?
fi

# 文件路径
PLIST_FILE="/Users/linzhang/Desktop/医学科研合作平台/com.researchpartner.monitor.plist"
LAUNCH_AGENTS_DIR="/Library/LaunchAgents"
INSTALLED_PLIST="$LAUNCH_AGENTS_DIR/com.researchpartner.monitor.plist"

# 检查plist文件是否存在
if [ ! -f "$PLIST_FILE" ]; then
    echo "❌ 错误：找不到plist文件: $PLIST_FILE"
    exit 1
fi

echo "📋 安装信息："
echo "   源文件: $PLIST_FILE"
echo "   目标位置: $INSTALLED_PLIST"
echo "   运行时间: 每天9:00和17:00"
echo ""

# 复制plist文件到LaunchAgents目录
echo "📁 复制配置文件..."
cp "$PLIST_FILE" "$INSTALLED_PLIST"
if [ $? -ne 0 ]; then
    echo "❌ 复制文件失败"
    exit 1
fi
echo "✅ 配置文件复制完成"

# 设置文件权限
echo "🔒 设置文件权限..."
chmod 644 "$INSTALLED_PLIST"
if [ $? -ne 0 ]; then
    echo "❌ 设置权限失败"
    exit 1
fi
echo "✅ 文件权限设置完成"

# 加载定时任务
echo "🔄 加载定时任务..."
launchctl load "$INSTALLED_PLIST"
if [ $? -ne 0 ]; then
    echo "❌ 加载定时任务失败"
    exit 1
fi
echo "✅ 定时任务加载完成"

# 立即测试运行
echo "🧪 测试运行..."
sudo -u linzhang /Users/linzhang/Desktop/医学科研合作平台/auto_run_monitor.sh
if [ $? -ne 0 ]; then
    echo "⚠️  测试运行可能有问题，请检查日志"
else
    echo "✅ 测试运行成功"
fi

echo ""
echo "=========================================="
echo "🎉 安装完成！"
echo ""
echo "📅 定时任务已设置："
echo "   • 每天早上9:00自动打开监控面板"
echo "   • 每天下午5:00自动打开监控面板"
echo ""
echo "📊 监控面板位置："
echo "   /Users/linzhang/Desktop/医学科研合作平台/科研合伙人监控面板.html"
echo ""
echo "📝 日志文件："
echo "   /Users/linzhang/Desktop/医学科研合作平台/auto_run_log.txt"
echo ""
echo "🔧 管理命令："
echo "   查看状态: launchctl list | grep researchpartner"
echo "   停止任务: sudo launchctl unload $INSTALLED_PLIST"
echo "   启动任务: sudo launchctl load $INSTALLED_PLIST"
echo "   查看日志: tail -f /Users/linzhang/Desktop/医学科研合作平台/auto_run_log.txt"
echo ""
echo "💖 你的科研合伙人：刘亦菲"
echo "=========================================="