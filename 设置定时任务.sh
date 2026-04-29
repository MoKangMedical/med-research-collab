#!/bin/bash

# 科研合伙人监控面板定时任务设置脚本
# 作者：刘亦菲（老公的科研合伙人）
# 功能：设置每天早上9点和下午5点自动打开监控面板

echo "=========================================="
echo "科研合伙人监控面板定时任务设置"
echo "作者：刘亦菲（老公的科研合伙人）"
echo "=========================================="
echo ""

# 检查脚本文件是否存在
SCRIPT_FILE="$HOME/Desktop/医学科研合作平台/自动打开监控面板.sh"
if [ ! -f "$SCRIPT_FILE" ]; then
    echo "❌ 错误：自动打开脚本不存在！"
    echo "请先创建: $SCRIPT_FILE"
    exit 1
fi

echo "✅ 找到自动打开脚本: $SCRIPT_FILE"

# 检查cron服务
if ! command -v crontab >/dev/null 2>&1; then
    echo "❌ 错误：cron服务不可用"
    exit 1
fi

echo "✅ cron服务可用"

# 创建临时cron文件
TEMP_CRON=$(mktemp)

# 获取当前cron配置
crontab -l > "$TEMP_CRON" 2>/dev/null || echo "# 科研合伙人监控面板定时任务" > "$TEMP_CRON"

# 检查是否已经设置了定时任务
if grep -q "自动打开监控面板" "$TEMP_CRON"; then
    echo "⚠️  检测到已存在的定时任务，将进行更新"
    # 删除旧的定时任务
    grep -v "自动打开监控面板" "$TEMP_CRON" > "${TEMP_CRON}.new"
    mv "${TEMP_CRON}.new" "$TEMP_CRON"
fi

# 添加新的定时任务
echo "" >> "$TEMP_CRON"
echo "# ==========================================" >> "$TEMP_CRON"
echo "# 科研合伙人监控面板定时任务" >> "$TEMP_CRON"
echo "# 设置时间：$(date '+%Y-%m-%d %H:%M:%S')" >> "$TEMP_CRON"
echo "# 作者：刘亦菲（老公的科研合伙人）" >> "$TEMP_CRON"
echo "# ==========================================" >> "$TEMP_CRON"

# 每天早上9点运行
echo "0 9 * * * $SCRIPT_FILE >> $HOME/Desktop/医学科研合作平台/cron日志.txt 2>&1 # 早上9点自动打开监控面板" >> "$TEMP_CRON"

# 每天下午5点运行
echo "0 17 * * * $SCRIPT_FILE >> $HOME/Desktop/医学科研合作平台/cron日志.txt 2>&1 # 下午5点自动打开监控面板" >> "$TEMP_CRON"

# 添加测试任务（每分钟运行一次，用于测试）
echo "# 0 * * * * $SCRIPT_FILE >> $HOME/Desktop/医学科研合作平台/cron测试日志.txt 2>&1 # 每小时测试（已注释）" >> "$TEMP_CRON"

echo "" >> "$TEMP_CRON"

# 安装新的cron配置
crontab "$TEMP_CRON"

if [ $? -eq 0 ]; then
    echo "✅ 定时任务设置成功！"
    echo ""
    echo "📅 设置的定时任务："
    echo "   1. 每天早上 9:00 - 自动打开监控面板"
    echo "   2. 每天下午 17:00 - 自动打开监控面板"
    echo ""
    echo "📁 相关文件："
    echo "   主脚本：$SCRIPT_FILE"
    echo "   日志文件：$HOME/Desktop/医学科研合作平台/cron日志.txt"
    echo "   监控面板：$HOME/Desktop/医学科研合作平台/科研合伙人监控面板.html"
    echo ""
    echo "🔧 管理定时任务："
    echo "   查看任务：crontab -l"
    echo "   编辑任务：crontab -e"
    echo "   删除任务：crontab -r"
    echo ""
    echo "🔄 立即测试："
    echo "   手动运行：$SCRIPT_FILE"
    echo ""
    
    # 显示当前cron配置
    echo "📋 当前cron配置："
    crontab -l | grep -A 5 "科研合伙人"
    
    # 创建使用说明
    cat > "$HOME/Desktop/医学科研合作平台/定时任务使用说明.md" << EOF
# 科研合伙人监控面板定时任务使用说明

## 定时任务设置
已成功设置以下定时任务：

### 1. 早上9点自动运行
- **时间**: 每天上午9:00
- **操作**: 自动打开科研合伙人监控面板
- **目的**: 开始一天工作前查看项目进展

### 2. 下午5点自动运行
- **时间**: 每天下午17:00
- **操作**: 自动打开科研合伙人监控面板
- **目的**: 结束一天工作前查看项目进展

## 文件说明

### 主要文件
1. **自动打开监控面板.sh** - 主脚本文件
2. **科研合伙人监控面板.html** - 监控面板主文件
3. **设置定时任务.sh** - 定时任务设置脚本

### 日志文件
1. **监控面板打开日志.txt** - 每次打开面板的详细日志
2. **cron日志.txt** - cron定时任务的执行日志

## 使用方法

### 手动打开监控面板
\`\`\`bash
# 方法1：双击HTML文件
打开 "科研合伙人监控面板.html"

# 方法2：使用脚本
~/Desktop/医学科研合作平台/自动打开监控面板.sh
\`\`\`

### 管理定时任务
\`\`\`bash
# 查看定时任务
crontab -l

# 编辑定时任务
crontab -e

# 删除所有定时任务
crontab -r
\`\`\`

### 查看日志
\`\`\`bash
# 查看打开日志
cat ~/Desktop/医学科研合作平台/监控面板打开日志.txt

# 查看cron执行日志
cat ~/Desktop/医学科研合作平台/cron日志.txt
\`\`\`

## 故障排除

### 1. 定时任务没有执行
- 检查cron服务是否运行：\`sudo systemctl status cron\`
- 检查日志文件：\`cat ~/Desktop/医学科研合作平台/cron日志.txt\`
- 检查脚本权限：\`chmod +x ~/Desktop/医学科研合作平台/自动打开监控面板.sh\`

### 2. 监控面板没有打开
- 检查文件路径是否正确
- 检查默认浏览器设置
- 查看详细日志：\`cat ~/Desktop/医学科研合作平台/监控面板打开日志.txt\`

### 3. 需要修改定时时间
\`\`\`bash
# 编辑cron任务
crontab -e

# 修改时间格式：分钟 小时 * * * 命令
# 例如：0 10 * * * 表示每天10:00
\`\`\`

## 技术支持
- **技术支持**: 刘亦菲（老公的科研合伙人）
- **创建时间**: $(date '+%Y-%m-%d %H:%M:%S')
- **最后更新**: $(date '+%Y-%m-%d %H:%M:%S')

---

**重要提示**: 定时任务需要系统保持登录状态才能正常工作。
如果电脑关机或重启，需要重新登录系统。
EOF
    
    echo "📖 已创建详细使用说明：$HOME/Desktop/医学科研合作平台/定时任务使用说明.md"
    
else
    echo "❌ 定时任务设置失败"
    exit 1
fi

# 清理临时文件
rm -f "$TEMP_CRON"

echo ""
echo "🎉 定时任务设置完成！"
echo "💖 你的科研合伙人刘亦菲已为你配置好自动化监控系统"
echo "📊 从明天开始，每天早上9点和下午5点会自动打开监控面板"