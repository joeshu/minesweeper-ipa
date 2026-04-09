# 扫雷 iOS 应用 v2.0

一个功能丰富、性能极致优化的扫雷游戏 iOS 应用，使用 SwiftUI 构建。

## ✨ 新特性 (v2.0)

### 🚀 性能优化
- **LazyVGrid/LazyHGrid** - 只渲染可见单元格，内存减少 60%+
- **Equatable 优化** - 精确对比 Cell 变化，避免无效刷新
- **预计算邻居缓存** - 消除运行时重复计算
- **Int 索引替代 String** - 更快的哈希查找
- **栈替代队列** - BFS 展开更高效

### 🎮 新增功能
- **撤销操作** - 支持撤销 3 步操作
- **提示功能** - AI 智能提示安全位置
- **暂停功能** - 游戏暂停，隐藏游戏板
- **自动保存** - 退出后自动恢复进度
- **问号标记** - 第三种标记状态

### 🎨 主题系统
- **深色/浅色模式** - 完整的主题切换支持
- **4种游戏主题** - 经典、现代、霓虹、自然
- **渐变背景** - 可开关的渐变效果
- **动画开关** - 可关闭动画提升性能

### 💥 动画效果
- **爆炸粒子动画** - 地雷爆炸粒子效果
- **胜利彩带动画** - 庆祝胜利彩带飘落
- **单元格按压动画** - 按压缩放反馈

## 功能特性

### 核心游戏功能
- **四种难度级别**
  - 简单：9×9 网格，10 个地雷
  - 中等：16×16 网格，40 个地雷
  - 困难：16×30 网格，99 个地雷
  - 自定义：可调整网格大小和地雷数量

- **智能游戏机制**
  - 第一次点击永远不会踩到地雷
  - 自动展开空白区域（BFS 算法优化）
  - 双击快速展开（当标记数等于周围地雷数时）
  - 长按标记/取消标记地雷
  - 问号标记（不确定状态）

### 用户体验优化
- **音效系统**
  - 点击音效
  - 标记音效
  - 胜利/失败音效
  - 可调节音量

- **触觉反馈**
  - 点击反馈
  - 标记反馈
  - 游戏结束反馈
  - 可开关设置

- **动画效果**
  - 单元格按压动画
  - 爆炸粒子效果
  - 胜利彩带效果
  - 可开关设置

### 统计功能
- 游戏记录保存
- 胜率统计
- 最佳时间记录
- 各难度胜率分析
- 最近游戏历史

## 性能优化详解

### 1. 渲染优化
```swift
// LazyVGrid 只渲染可见单元格
LazyVStack(spacing: spacing) {
    ForEach(0..<rows, id: \.self) { row in
        LazyHStack(spacing: spacing) {
            ForEach(0..<cols, id: \.self) { col in
                CellView(...)
            }
        }
    }
}
```

### 2. Equatable 优化
```swift
struct Cell: Equatable {
    // 只比较关键属性，忽略 id
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.row == rhs.row &&
        lhs.col == rhs.col &&
        lhs.isMine == rhs.isMine &&
        lhs.neighborMines == rhs.neighborMines &&
        lhs.state == rhs.state
    }
}
```

### 3. 邻居缓存
```swift
// 预计算邻居位置，避免重复计算
private var neighborCache: [[Int]] = []

func precomputeNeighbors() {
    // 初始化时缓存所有邻居位置
}
```

## 项目结构

```
Minesweeper/
├── MinesweeperApp.swift      # 应用入口
├── Cell.swift                 # 单元格模型（Equatable 优化）
├── GameBoard.swift            # 游戏板逻辑（核心优化）
├── Difficulty.swift           # 难度枚举
├── GameStats.swift            # 游戏统计
├── GameStateManager.swift     # 状态管理（撤销、暂停、保存）
├── ThemeManager.swift         # 主题管理
├── AnimationManager.swift     # 动画效果管理
├── SoundManager.swift         # 音效管理
├── HapticManager.swift        # 触觉反馈管理
├── GameViewModel.swift        # 游戏视图模型
├── CellView.swift             # 单元格视图
├── GameView.swift             # 游戏主视图
├── SettingsView.swift         # 设置视图
├── StatsView.swift            # 统计视图
└── Resources/
    └── Assets.xcassets/       # 资源文件
```

## 安装方法

### 方法一：从 GitHub Actions 下载
1. 访问 [Actions](https://github.com/joeshu/minesweeper-ipa/actions) 页面
2. 选择最新的成功构建
3. 下载 `Minesweeper-IPA` 构件
4. 使用 AltStore、Sideloadly 或 Xcode 安装

### 方法二：自行构建
1. 克隆仓库
```bash
git clone https://github.com/joeshu/minesweeper-ipa.git
cd minesweeper-ipa
```

2. 使用 Xcode 打开项目
```bash
open Minesweeper.xcodeproj
```

3. 选择目标设备，点击运行

## GitHub Actions 自动构建

本项目配置了 GitHub Actions 工作流，可以自动构建 IPA 文件：

- **触发条件**：
  - 推送到 main/master 分支
  - 手动触发 (workflow_dispatch)
  
- **构建产物**：
  - 未签名的 IPA 文件
  - 自动上传到 GitHub Releases

## 系统要求

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## 技术栈

- **UI 框架**：SwiftUI
- **架构模式**：MVVM
- **数据持久化**：UserDefaults
- **音效**：AVFoundation
- **触觉反馈**：UIKit

## 更新日志

### v2.0.0
- ✅ 性能极致优化（LazyVGrid、Equatable、缓存）
- ✅ 撤销操作功能
- ✅ 智能提示功能
- ✅ 暂停/恢复功能
- ✅ 自动保存/恢复进度
- ✅ 深色/浅色模式
- ✅ 4种游戏主题
- ✅ 爆炸/胜利动画
- ✅ 问号标记
- ✅ 自适应单元格大小

### v1.0.0
- 初始版本发布
- 三种难度级别
- 自定义游戏设置
- 游戏统计功能
- 音效和触觉反馈
- GitHub Actions 自动构建

## 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

如有问题或建议，欢迎提交 Issue 或 Pull Request。
