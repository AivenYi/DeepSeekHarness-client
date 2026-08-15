# DeepSeek Harness v1.0.0 Windows

## 中文

这是 DeepSeek Harness 的 Windows 安装包发行版本。普通用户只需要下载 `DeepSeekHarness-Setup.exe`，双击后跟随安装向导点击下一步即可完成安装。

### 本版本包含

- 标准 Windows 安装向导：`DeepSeekHarness-Setup.exe`
- 自动复制 `Harness.exe` 和运行所需文件
- 自动创建桌面快捷方式和开始菜单入口
- 注册 Windows 卸载入口
- 提供 `plugin-config.example.json`，用于说明图片自动分析插件的用户 API 配置方向
- 提供脱敏后的安装、构建、安全和发布文档

### 推荐安装方式

1. 下载 `DeepSeekHarness-Setup.exe`。
2. 双击安装包。
3. 按向导选择安装目录。
4. 保留桌面快捷方式选项。
5. 点击完成后启动 `DeepSeek Harness`。

### 关于来源和用途

本项目基于已打包成功的 DeepSeek Harness Windows 版本整理而来，目的是让用户可以像安装普通 Windows 软件一样使用 DeepSeek 客户端。DeepSeek 官方主要提供网页端体验，本项目补齐桌面端安装入口，并保留图片自动分析插件的扩展方向：用户在聊天时上传图片，由插件先完成图像分析，再继续使用 DeepSeek 模型对话。

本仓库不是 DeepSeek 官方项目，也不是 DeepSeek Harness 的完整上游源码仓库。

### 关于 API Key

本仓库不应包含任何个人 API Key、Cookie、访问令牌或用户会话数据。图片自动分析插件的目标是让用户填写自己的 API，而不是使用开发者的 API。当前公开发行工程只包含空的示例配置。

### APK 和 macOS

当前可验证发行物是 Windows 安装包。APK 和 macOS 版本不能由这个 Windows WebView2 可执行文件直接转换出来，需要分别构建 Android WebView/Tauri Mobile 工程，以及 macOS WebView `.app`/`.dmg`/`.pkg` 工程。

## English

This is the Windows installer release for DeepSeek Harness. End users should download `DeepSeekHarness-Setup.exe`, double-click it, and follow the setup wizard.

This release provides a standard Windows installation flow, desktop and Start Menu shortcuts, uninstall registration, sanitized release documentation, and an example configuration file for the intended image auto-analysis API setup.

The repository is not the official DeepSeek project and is not the full upstream DeepSeek Harness source tree. It is a sanitized Windows release workspace built for easier desktop distribution.
