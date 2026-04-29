#!/bin/bash
echo "配置Python环境..."

# 创建虚拟环境
python3 -m venv ~/venv/research

# 激活虚拟环境的脚本
cat > ~/Desktop/医学科研合作平台/激活科研环境.sh << 'SCRIPT'
#!/bin/bash
source ~/venv/research/bin/activate
echo "✅ 科研Python环境已激活"
SCRIPT

chmod +x ~/Desktop/医学科研合作平台/激活科研环境.sh

echo "✅ Python环境配置完成"
echo "使用: source ~/Desktop/医学科研合作平台/激活科研环境.sh"
