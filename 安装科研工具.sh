#!/bin/bash

# 科研工具自动化安装脚本
# 作者：刘亦菲（老公的科研合伙人）
# 功能：安装全球主要科研辅助平台和工具

echo "=========================================="
echo "科研工具自动化安装脚本"
echo "作者：刘亦菲（老公的科研合伙人）"
echo "时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
echo ""

# 日志文件
LOG_FILE="$HOME/Desktop/医学科研合作平台/科研工具安装日志.txt"
echo "安装开始时间: $(date '+%Y-%m-%d %H:%M:%S')" > "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

# 检查系统
echo "🔍 检查系统信息..."
echo "系统信息:" >> "$LOG_FILE"
uname -a >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 检查Homebrew
echo "🍺 检查Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
    echo "安装Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "✅ Homebrew安装完成" >> "$LOG_FILE"
else
    echo "✅ Homebrew已安装" >> "$LOG_FILE"
    brew --version >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 更新Homebrew
echo "🔄 更新Homebrew..."
brew update >> "$LOG_FILE" 2>&1
brew upgrade >> "$LOG_FILE" 2>&1
echo "✅ Homebrew更新完成" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 安装Python和相关工具
echo "🐍 安装Python和相关工具..."
echo "Python安装:" >> "$LOG_FILE"

# 检查Python3
if ! command -v python3 >/dev/null 2>&1; then
    echo "安装Python3..."
    brew install python@3.12 >> "$LOG_FILE" 2>&1
    echo "✅ Python3安装完成" >> "$LOG_FILE"
else
    echo "✅ Python3已安装" >> "$LOG_FILE"
    python3 --version >> "$LOG_FILE"
fi

# 检查pip3
if ! command -v pip3 >/dev/null 2>&1; then
    echo "安装pip3..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py >> "$LOG_FILE" 2>&1
    rm get-pip.py
    echo "✅ pip3安装完成" >> "$LOG_FILE"
else
    echo "✅ pip3已安装" >> "$LOG_FILE"
    pip3 --version >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装Python科学计算包
echo "📊 安装Python科学计算包..."
echo "Python包安装:" >> "$LOG_FILE"

# 基础科学计算包
BASIC_PACKAGES="numpy pandas matplotlib scipy sympy"
echo "安装基础包: $BASIC_PACKAGES"
pip3 install $BASIC_PACKAGES >> "$LOG_FILE" 2>&1

# 数据科学包
DATA_SCIENCE_PACKAGES="scikit-learn seaborn plotly jupyter notebook"
echo "安装数据科学包: $DATA_SCIENCE_PACKAGES"
pip3 install $DATA_SCIENCE_PACKAGES >> "$LOG_FILE" 2>&1

# 生物信息学包
BIO_PACKAGES="biopython pysam pybedtools"
echo "安装生物信息学包: $BIO_PACKAGES"
pip3 install $BIO_PACKAGES >> "$LOG_FILE" 2>&1

# 其他有用包
OTHER_PACKAGES="requests beautifulsoup4 lxml openpyxl xlrd"
echo "安装其他包: $OTHER_PACKAGES"
pip3 install $OTHER_PACKAGES >> "$LOG_FILE" 2>&1

echo "✅ Python包安装完成" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 安装R语言
echo "📈 安装R语言..."
echo "R语言安装:" >> "$LOG_FILE"

if ! command -v R >/dev/null 2>&1; then
    echo "安装R..."
    brew install r >> "$LOG_FILE" 2>&1
    echo "✅ R语言安装完成" >> "$LOG_FILE"
    R --version >> "$LOG_FILE"
else
    echo "✅ R语言已安装" >> "$LOG_FILE"
    R --version >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装RStudio
echo "💻 安装RStudio..."
echo "RStudio安装:" >> "$LOG_FILE"

if [ ! -d "/Applications/RStudio.app" ]; then
    echo "下载RStudio..."
    RSTUDIO_URL="https://download1.rstudio.org/electron/macos/RStudio-2023.12.1-402.dmg"
    RSTUDIO_DMG="/tmp/rstudio.dmg"
    
    curl -L -o "$RSTUDIO_DMG" "$RSTUDIO_URL"
    
    if [ -f "$RSTUDIO_DMG" ]; then
        echo "挂载DMG文件..."
        hdiutil attach "$RSTUDIO_DMG" -nobrowse
        
        echo "复制到应用程序..."
        cp -R "/Volumes/RStudio/RStudio.app" /Applications/
        
        echo "卸载DMG文件..."
        hdiutil detach "/Volumes/RStudio"
        
        rm "$RSTUDIO_DMG"
        echo "✅ RStudio安装完成" >> "$LOG_FILE"
    else
        echo "❌ RStudio下载失败" >> "$LOG_FILE"
    fi
else
    echo "✅ RStudio已安装" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装Git
echo "🔧 安装Git..."
echo "Git安装:" >> "$LOG_FILE"

if ! command -v git >/dev/null 2>&1; then
    echo "安装Git..."
    brew install git >> "$LOG_FILE" 2>&1
    echo "✅ Git安装完成" >> "$LOG_FILE"
    git --version >> "$LOG_FILE"
else
    echo "✅ Git已安装" >> "$LOG_FILE"
    git --version >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装GitHub Desktop
echo "🐙 安装GitHub Desktop..."
echo "GitHub Desktop安装:" >> "$LOG_FILE"

if [ ! -d "/Applications/GitHub Desktop.app" ]; then
    echo "下载GitHub Desktop..."
    GITHUB_DESKTOP_URL="https://central.github.com/deployments/desktop/desktop/latest/darwin"
    GITHUB_DESKTOP_DMG="/tmp/github-desktop.dmg"
    
    curl -L -o "$GITHUB_DESKTOP_DMG" "$GITHUB_DESKTOP_URL"
    
    if [ -f "$GITHUB_DESKTOP_DMG" ]; then
        echo "挂载DMG文件..."
        hdiutil attach "$GITHUB_DESKTOP_DMG" -nobrowse
        
        echo "复制到应用程序..."
        cp -R "/Volumes/GitHub Desktop/GitHub Desktop.app" /Applications/
        
        echo "卸载DMG文件..."
        hdiutil detach "/Volumes/GitHub Desktop"
        
        rm "$GITHUB_DESKTOP_DMG"
        echo "✅ GitHub Desktop安装完成" >> "$LOG_FILE"
    else
        echo "❌ GitHub Desktop下载失败" >> "$LOG_FILE"
    fi
else
    echo "✅ GitHub Desktop已安装" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装Zotero（文献管理）
echo "📚 安装Zotero..."
echo "Zotero安装:" >> "$LOG_FILE"

if [ ! -d "/Applications/Zotero.app" ]; then
    echo "下载Zotero..."
    ZOTERO_URL="https://download.zotero.org/client/release/6.0.30/Zotero-6.0.30.dmg"
    ZOTERO_DMG="/tmp/zotero.dmg"
    
    curl -L -o "$ZOTERO_DMG" "$ZOTERO_URL"
    
    if [ -f "$ZOTERO_DMG" ]; then
        echo "挂载DMG文件..."
        hdiutil attach "$ZOTERO_DMG" -nobrowse
        
        echo "复制到应用程序..."
        cp -R "/Volumes/Zotero/Zotero.app" /Applications/
        
        echo "卸载DMG文件..."
        hdiutil detach "/Volumes/Zotero"
        
        rm "$ZOTERO_DMG"
        echo "✅ Zotero安装完成" >> "$LOG_FILE"
    else
        echo "❌ Zotero下载失败" >> "$LOG_FILE"
    fi
else
    echo "✅ Zotero已安装" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装JupyterLab
echo "📓 安装JupyterLab..."
echo "JupyterLab安装:" >> "$LOG_FILE"

pip3 install jupyterlab >> "$LOG_FILE" 2>&1
echo "✅ JupyterLab安装完成" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 安装VS Code
echo "👨‍💻 安装VS Code..."
echo "VS Code安装:" >> "$LOG_FILE"

if [ ! -d "/Applications/Visual Studio Code.app" ]; then
    echo "下载VS Code..."
    VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
    VSCODE_ZIP="/tmp/vscode.zip"
    
    curl -L -o "$VSCODE_ZIP" "$VSCODE_URL"
    
    if [ -f "$VSCODE_ZIP" ]; then
        echo "解压文件..."
        unzip -q "$VSCODE_ZIP" -d /Applications/
        
        rm "$VSCODE_ZIP"
        echo "✅ VS Code安装完成" >> "$LOG_FILE"
    else
        echo "❌ VS Code下载失败" >> "$LOG_FILE"
    fi
else
    echo "✅ VS Code已安装" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装Docker
echo "🐳 安装Docker..."
echo "Docker安装:" >> "$LOG_FILE"

if [ ! -d "/Applications/Docker.app" ]; then
    echo "下载Docker..."
    DOCKER_URL="https://desktop.docker.com/mac/main/amd64/Docker.dmg"
    DOCKER_DMG="/tmp/docker.dmg"
    
    curl -L -o "$DOCKER_DMG" "$DOCKER_URL"
    
    if [ -f "$DOCKER_DMG" ]; then
        echo "挂载DMG文件..."
        hdiutil attach "$DOCKER_DMG" -nobrowse
        
        echo "复制到应用程序..."
        cp -R "/Volumes/Docker/Docker.app" /Applications/
        
        echo "卸载DMG文件..."
        hdiutil detach "/Volumes/Docker"
        
        rm "$DOCKER_DMG"
        echo "✅ Docker安装完成" >> "$LOG_FILE"
    else
        echo "❌ Docker下载失败" >> "$LOG_FILE"
    fi
else
    echo "✅ Docker已安装" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"

# 安装其他有用工具
echo "🛠️ 安装其他有用工具..."
echo "其他工具安装:" >> "$LOG_FILE"

# 安装wget
brew install wget >> "$LOG_FILE" 2>&1

# 安装tree
brew install tree >> "$LOG_FILE" 2>&1

# 安装htop
brew install htop >> "$LOG_FILE" 2>&1

# 安装jq
brew install jq >> "$LOG_FILE" 2>&1

# 安装yq
brew install yq >> "$LOG_FILE" 2>&1

echo "✅ 其他工具安装完成" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 创建配置文件
echo "⚙️ 创建配置文件..."
echo "配置文件:" >> "$LOG_FILE"

# 创建科研工作目录
mkdir -p ~/科研工作
mkdir -p ~/科研工作/文献
mkdir -p ~/科研工作/数据
mkdir -p ~/科研工作/代码
mkdir -p ~/科研工作/论文
mkdir -p ~/科研工作/实验记录

echo "科研工作目录创建完成" >> "$LOG_FILE"

# 创建Git配置脚本
cat > ~/Desktop/医学科研合作平台/配置Git.sh << 'EOF'
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
EOF

chmod +x ~/Desktop/医学科研合作平台/配置Git.sh
echo "Git配置脚本创建完成" >> "$LOG_FILE"

# 创建Python环境配置
cat > ~/Desktop/医学科研合作平台/配置Python环境.sh << 'EOF'
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
EOF

chmod +x ~/Desktop/医学科研合作平台/配置Python环境.sh
echo "Python环境配置脚本创建完成" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"

# 安装完成总结
echo "🎉 安装完成！"
echo "安装完成时间: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

# 显示安装总结
echo ""
echo "=========================================="
echo "✅ 科研工具安装完成"
echo "=========================================="
echo ""
echo "📋 已安装的工具:"
echo "   🐍 Python 3.12 + 科学计算包"
echo "   📈 R语言 + RStudio"
echo "   🔧 Git + GitHub Desktop"
echo "   📚 Zotero（文献管理）"
echo "   📓 JupyterLab"
echo "   👨‍💻 VS Code"
echo "   🐳 Docker"
echo "   🛠️ 其他工具（wget, tree, htop, jq, yq）"
echo ""
echo "📁 创建的目录:"
echo "   ~/科研工作/ - 科研工作主目录"
echo "   ~/科研工作/文献/ - 文献管理"
echo "   ~/科研工作/数据/ - 数据存储"
echo "   ~/科研工作/代码/ - 代码管理"
echo "   ~/科研工作/论文/ - 论文写作"
echo "   ~/科研工作/实验记录/ - 实验记录"
echo ""
echo "⚙️ 需要配置:"
echo "   1. 运行 ~/Desktop/医学科研合作平台/配置Git.sh"
echo "   2. 运行 ~/Desktop/医学科研合作平台/配置Python环境.sh"
echo ""
echo "📝 详细日志: $LOG_FILE"
echo ""
echo "💖 你的科研合伙人刘亦菲已为你准备好所有科研工具！"
echo "🚀 现在可以开始我们的医学科研合作了！"