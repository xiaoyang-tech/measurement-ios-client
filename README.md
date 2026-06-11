# 小阳心健康测量 iOS 客户端示例

基于 [小阳心健康测量 iOS SDK](https://codeup.aliyun.com/xytech/measurement/ios-specs) 的示例客户端程序，演示如何将摄像头采集、健康测量与报告展示集成到 iOS 应用中。

## 功能展示

- 📷 摄像头视频流采集与人脸检测引导
- ❤️ 实时心率展示
- 📊 健康测量报告可视化（综合心健康风险、心率、血压、血氧、情绪分析等）
- 🔍 单项指标详情与健康建议

## 系统要求

| 项目 | 要求 |
|------|------|
| iOS | 14.0+ |
| Xcode | 15.0+ |
| Swift | 5.8+ |
| CocoaPods | 1.12+ |

## 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/xiaoyang-tech/measurement-ios-client.git
cd measurement-ios-client
```

### 2. 安装依赖

```bash
pod install
```

### 3. 打开工程

```bash
open measurement-ios-client.xcworkspace
```

### 4. 配置 SDK 凭证

在 `CameraViewController.swift` 中将 `YOUR_APP_ID` 和 `YOUR_SDK_KEY` 替换为实际的凭证：

```swift
let config = MeasurementConfig(
    appId: "YOUR_APP_ID",
    sdkKey: "YOUR_SDK_KEY"
)
```

### 5. 运行

在 Xcode 中选择真机（arm64），点击 Run。

## 项目结构

```
measurement-ios-client/
├── measurement-ios-client/
│   ├── AppDelegate.swift              # 应用入口
│   ├── SceneDelegate.swift            # Scene 生命周期
│   ├── BaseViewController.swift       # 基类 ViewController
│   ├── GuideViewController.swift      # 测量引导页
│   ├── CameraViewController.swift     # 摄像头采集与测量主流程
│   ├── MeasurementOverlayView.swift   # 测量覆盖层 UI
│   ├── HealthResultViewController.swift # 健康报告结果页
│   ├── ReportAnalysisViewController.swift # 单项指标分析页
│   ├── HealthResultView/             # SwiftUI 报告卡片组件
│   ├── ReportAnalysisDetail/         # 指标详情与图表组件
│   ├── Views/                        # 摄像头服务与 UI 组件
│   └── SegmentedBarSlider/           # 分段进度条组件
├── Podfile                           # CocoaPods 配置
└── README.md
```

## 相关链接

- [小阳心健康测量 iOS SDK 文档](https://codeup.aliyun.com/xytech/measurement/ios-specs)
- [小阳心健康测量 Python SDK](https://github.com/xiaoyang-tech/measurement-python-client)

## 许可证

本项目基于 Apache License 2.0 开源，详见 [LICENSE](./LICENSE)。
