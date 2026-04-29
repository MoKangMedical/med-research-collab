#!/bin/bash

# 科研合伙人监控面板自动运行脚本
# 作者：刘亦菲 (科研合伙人)
# 功能：每天早上9点和下午5点自动打开监控面板

# 设置环境
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# 日志文件
LOG_FILE="$HOME/Desktop/医学科研合作平台/auto_run_log.txt"

# 监控面板文件路径
MONITOR_FILE="$HOME/Desktop/医学科研合作平台/科研合伙人监控面板.html"

# 记录日志函数
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" >> "$LOG_FILE"
}

# 检查文件是否存在
check_files() {
    if [ ! -f "$MONITOR_FILE" ]; then
        log_message "错误：监控面板文件不存在: $MONITOR_FILE"
        return 1
    fi
    return 0
}

# 打开监控面板
open_monitor() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local current_time=$(date '+%H:%M')
    
    log_message "开始自动运行监控面板 (时间: $current_time)"
    
    # 在macOS上使用open命令打开HTML文件
    if command -v open >/dev/null 2>&1; then
        open "$MONITOR_FILE"
        log_message "成功打开监控面板"
        
        # 显示通知 (macOS)
        if command -v osascript >/dev/null 2>&1; then
            osascript -e "display notification \"科研项目监控面板已自动打开\" with title \"科研合伙人系统\" subtitle \"时间: $current_time\""
        fi
    else
        log_message "错误：无法找到open命令"
        return 1
    fi
    
    return 0
}

# 主函数
main() {
    # 创建日志目录
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # 记录开始时间
    log_message "=== 科研合伙人监控面板自动运行开始 ==="
    
    # 检查文件
    if ! check_files; then
        log_message "文件检查失败，退出"
        exit 1
    fi
    
    # 打开监控面板
    if open_monitor; then
        log_message "自动运行完成"
    else
        log_message "自动运行失败"
        exit 1
    fi
    
    log_message "=== 科研合伙人监控面板自动运行结束 ==="
}

# 执行主函数
main "$@"