#!/bin/bash

# 科研合伙人监控面板自动打开脚本
# 作者：刘亦菲（老公的科研合伙人）
# 功能：每天早上9点和下午5点自动打开监控面板

# 设置环境
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# 日志文件
LOG_FILE="$HOME/Desktop/医学科研合作平台/监控面板打开日志.txt"

# 获取当前时间
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
echo "==========================================" >> "$LOG_FILE"
echo "执行时间: $CURRENT_TIME" >> "$LOG_FILE"

# 监控面板文件路径
MONITOR_FILE="$HOME/Desktop/医学科研合作平台/科研合伙人监控面板.html"

# 检查文件是否存在
if [ ! -f "$MONITOR_FILE" ]; then
    echo "错误：监控面板文件不存在！" >> "$LOG_FILE"
    echo "文件路径: $MONITOR_FILE" >> "$LOG_FILE"
    exit 1
fi

echo "监控面板文件存在: $MONITOR_FILE" >> "$LOG_FILE"

# 获取文件信息
FILE_SIZE=$(du -h "$MONITOR_FILE" | cut -f1)
FILE_MODIFIED=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$MONITOR_FILE")
echo "文件大小: $FILE_SIZE" >> "$LOG_FILE"
echo "最后修改: $FILE_MODIFIED" >> "$LOG_FILE"

# 检查是否有浏览器进程
BROWSER_PID=$(pgrep -f "Google Chrome|Safari|Firefox" | head -1)
if [ -n "$BROWSER_PID" ]; then
    echo "检测到浏览器进程: PID $BROWSER_PID" >> "$LOG_FILE"
else
    echo "未检测到浏览器进程，将启动新浏览器" >> "$LOG_FILE"
fi

# 打开监控面板
echo "正在打开监控面板..." >> "$LOG_FILE"

# 尝试用默认浏览器打开
if command -v open >/dev/null 2>&1; then
    open "$MONITOR_FILE"
    echo "使用open命令打开文件" >> "$LOG_FILE"
    
    # 等待浏览器加载
    sleep 3
    
    # 检查是否成功打开
    if [ $? -eq 0 ]; then
        echo "✅ 监控面板已成功打开！" >> "$LOG_FILE"
        echo "打开时间: $(date "+%H:%M:%S")" >> "$LOG_FILE"
        
        # 显示通知（如果支持）
        if command -v osascript >/dev/null 2>&1; then
            osascript -e 'display notification "科研合伙人监控面板已自动打开" with title "科研项目监控" subtitle "刘亦菲提醒您查看项目进展"'
            echo "已发送系统通知" >> "$LOG_FILE"
        fi
    else
        echo "❌ 打开监控面板失败" >> "$LOG_FILE"
    fi
else
    echo "❌ 找不到open命令" >> "$LOG_FILE"
fi

# 记录系统信息
echo "" >> "$LOG_FILE"
echo "系统信息：" >> "$LOG_FILE"
echo "用户: $USER" >> "$LOG_FILE"
echo "主机名: $(hostname)" >> "$LOG_FILE"
echo "系统时间: $(date)" >> "$LOG_FILE"
echo "运行目录: $(pwd)" >> "$LOG_FILE"

echo "脚本执行完成" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 输出到控制台（如果手动运行）
echo "✅ 科研合伙人监控面板自动打开脚本执行完成"
echo "📝 详细日志请查看: $LOG_FILE"