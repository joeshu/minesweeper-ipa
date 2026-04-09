# 项目设置指南

## 概述

由于原始仓库 `https://github.com/joeshu/minesweeper-ipa-0408-151615.git` 不存在，我为你创建了一个全新的、优化后的扫雷 iOS 项目。

## 项目特性

### 性能优化
1. **BFS 算法**：使用队列实现空白区域展开，避免递归栈溢出
2. **延迟地雷放置**：第一次点击后才生成地雷，确保首次点击安全
3. **批量视图更新**：优化 SwiftUI 性能
4. **预加载资源**：音效预加载，减少游戏延迟

### 功能增强
1. **三种难度级别**：简单、中等、困难
2. **自定义设置**：可调整网格大小和地雷数量
3. **游戏统计**：胜率、最佳时间、历史记录
4. **音效系统**：点击、标记、胜利、失败音效
5. **触觉反馈**：多种触觉反馈模式
6. **快速展开**：双击快速展开周围单元格

## 快速开始

### 1. 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称：`minesweeper-ipa`
3. 选择公开或私有
4. 不要初始化 README（已包含）
5. 点击 "Create repository"

### 2. 推送代码到 GitHub

```bash
# 进入项目目录
cd minesweeper-ipa

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: Optimized Minesweeper iOS app with GitHub Actions"

# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/minesweeper-ipa.git

# 推送到 GitHub
git push -u origin main
```

### 3. 启用 GitHub Actions

1. 访问 `https://github.com/YOUR_USERNAME/minesweeper-ipa/actions`
2. 点击 "I understand my workflows, go ahead and enable them"
3. GitHub Actions 现在会自动运行

### 4. 触发构建

每次推送到 `main` 分支时，GitHub Actions 会自动构建 IPA 文件。

手动触发：
1. 访问 `https://github.com/YOUR_USERNAME/minesweeper-ipa/actions`
2. 选择 "Build IPA" 工作流
3. 点击 "Run workflow"

## 项目结构

```
minesweeper-ipa/
├── .github/
│   └── workflows/
│       └── build-ipa.yml      # GitHub Actions 工作流
├── Minesweeper/
│   ├── MinesweeperApp.swift   # 应用入口
│   ├── Cell.swift             # 单元格模型
│   ├── GameBoard.swift        # 游戏板逻辑（核心优化）
│   ├── Difficulty.swift       # 难度枚举
│   ├── GameStats.swift        # 游戏统计
│   ├── SoundManager.swift     # 音效管理
│   ├── HapticManager.swift    # 触觉反馈
│   ├── GameViewModel.swift    # 视图模型
│   ├── CellView.swift         # 单元格视图
│   ├── GameView.swift         # 游戏主视图
│   ├── SettingsView.swift     # 设置视图
│   ├── StatsView.swift        # 统计视图
│   └── Resources/
│       └── Assets.xcassets/   # 资源文件
├── Minesweeper.xcodeproj/     # Xcode 项目
├── README.md                  # 项目说明
├── LICENSE                    # MIT 许可证
└── .gitignore                 # Git 忽略文件
```

## 核心优化说明

### 1. GameBoard.swift - BFS 空白展开

```swift
// 使用队列进行广度优先搜索，优化大面积空白区域展开性能
var queue: [(Int, Int)] = [(row, col)]
var visited = Set<String>()

while !queue.isEmpty {
    let (currentRow, currentCol) = queue.removeFirst()
    // ... 展开逻辑
    
    // 如果是空白单元格，自动展开周围
    if cells[currentRow][currentCol].neighborMines == 0 {
        // 添加周围单元格到队列
    }
}
```

### 2. 延迟地雷放置

```swift
func revealCell(row: Int, col: Int) {
    // 第一次点击时放置地雷
    if firstMove {
        firstMove = false
        placeMines(excludingRow: row, excludingCol: col)
    }
    // ...
}
```

### 3. 快速展开功能

```swift
func quickReveal(row: Int, col: Int) {
    // 如果标记数等于周围地雷数，自动展开其他隐藏单元格
    if flagCount == cells[row][col].neighborMines {
        for (r, c) in hiddenCells {
            revealCell(row: r, col: c)
        }
    }
}
```

## GitHub Actions 工作流

### 构建流程
1. 检出代码
2. 设置 Xcode 环境
3. 构建归档文件
4. 导出 IPA（未签名）
5. 上传构建产物
6. 创建 GitHub Release

### 输出文件
- `Minesweeper-unsigned.ipa`：未签名的 IPA 文件

### 安装 IPA
1. 下载 IPA 文件
2. 使用以下工具安装：
   - **AltStore**（推荐）：https://altstore.io/
   - **Sideloadly**：https://sideloadly.io/
   - **Xcode**：使用 Apple Developer 账号

## 本地开发

### 要求
- macOS 14.0+
- Xcode 15.0+
- iOS 16.0+ 模拟器或设备

### 运行项目
1. 使用 Xcode 打开 `Minesweeper.xcodeproj`
2. 选择目标设备
3. 点击运行按钮（Cmd+R）

## 自定义配置

### 修改难度设置
编辑 `Difficulty.swift`：

```swift
var rows: Int {
    switch self {
    case .easy: return 9
    case .medium: return 16
    case .hard: return 16
    case .custom: return 16
    }
}
```

### 添加新音效
1. 将音效文件添加到 `Resources/Sounds/`
2. 在 `SoundManager.swift` 中预加载：

```swift
private func preloadSounds() {
    let sounds = ["click", "flag", "win", "lose", "your-sound"]
    // ...
}
```

## 故障排除

### GitHub Actions 构建失败
1. 检查 Xcode 版本兼容性
2. 查看构建日志获取详细错误信息
3. 确保 project.pbxproj 文件格式正确

### IPA 安装失败
1. 确保使用正确的安装工具
2. 在 iOS 设置中信任开发者证书
3. 检查 iOS 版本兼容性（需要 iOS 16.0+）

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License - 详见 LICENSE 文件
