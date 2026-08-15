# DeepSeek Harness

[![Platform](https://img.shields.io/badge/platform-Windows-0078D4?logo=windows&logoColor=white)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![Installer](https://img.shields.io/badge/installer-Setup.exe-2EA44F)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![Release](https://img.shields.io/github/v/release/AivenYi/DeepSeekHarness?include_prereleases&label=release)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![License](https://img.shields.io/github/license/AivenYi/DeepSeekHarness)](LICENSE)
[![Security](https://img.shields.io/badge/security-no%20keys%20committed-critical)](SECURITY.md)
[![WebView2](https://img.shields.io/badge/runtime-WebView2-5C2D91)](https://developer.microsoft.com/microsoft-edge/webview2/)
[![DeepSeek](https://img.shields.io/badge/model-DeepSeek-4B6BFB)](https://www.deepseek.com/)

English documentation: [README_EN.md](README_EN.md)

DeepSeek Harness 是一个面向普通用户的 Windows 桌面客户端。用户不需要手动解压 zip、不需要运行命令，只需要下载 `DeepSeekHarness-Setup.exe`，双击安装包，然后一路点击安装向导即可完成安装。

这个项目的核心目的很简单：让更多人更方便地使用 DeepSeek。DeepSeek 官方本身主要提供网页端体验，本项目基于已打包成功的 DeepSeek Harness 发行内容，补齐 Windows 客户端安装体验，并保留一个重要扩展方向：在聊天时，即使使用 DeepSeek 模型，也可以上传图片，并通过“图片自动分析”功能完成图像理解后再进入对话流程。

> 当前仓库公开的是脱敏后的 Windows 安装发行工程，不是 DeepSeek 官方项目，也不是 DeepSeek Harness 的完整上游源码仓库。

## 直接下载安装包

普通用户请直接下载这个文件：

[下载 DeepSeekHarness-Setup.exe](https://github.com/AivenYi/DeepSeekHarness/releases/download/v1.0.0-windows/DeepSeekHarness-Setup.exe)

备用入口：

- [GitHub Release 页面](https://github.com/AivenYi/DeepSeekHarness/releases/tag/v1.0.0-windows)
- [全部 Releases](https://github.com/AivenYi/DeepSeekHarness/releases)

下载后双击 `DeepSeekHarness-Setup.exe`，按安装向导一路点击下一步即可。安装完成后，可以从桌面快捷方式或开始菜单启动 `DeepSeek Harness`。

## 项目来源

- DeepSeek 品牌、模型与服务来源于 DeepSeek 官方：[https://www.deepseek.com/](https://www.deepseek.com/)
- 桌面窗口运行依赖 Microsoft Edge WebView2：[https://developer.microsoft.com/microsoft-edge/webview2/](https://developer.microsoft.com/microsoft-edge/webview2/)
- 当前仓库来源于本地已打包成功的 DeepSeek Harness Windows 版本，并参考了一个更轻量的 Rust/WebView2 启动器项目进行安装包整理。
- 本仓库只保存安装脚本、发布文档、示例配置和脱敏后的发行说明；不会提交个人 API Key、Cookie、浏览器缓存或用户会话数据。

## 为什么做这个

DeepSeek 网页端已经能满足很多使用场景，但普通用户通常更希望有一个可以直接安装、从桌面或开始菜单启动的客户端。本项目把已有的 Web 端能力封装成 Windows 桌面安装包，降低使用门槛。

另一个目标是增强多模态使用体验：用户在聊天时可以上传图片，由“图片自动分析”插件先完成图像分析，再把分析结果交给 DeepSeek 对话。这样可以在保持 DeepSeek 文本能力的同时，让图片输入也能参与工作流。

## 用户如何安装

1. 点击上面的 [下载 DeepSeekHarness-Setup.exe](https://github.com/AivenYi/DeepSeekHarness/releases/download/v1.0.0-windows/DeepSeekHarness-Setup.exe)。
2. 下载 `DeepSeekHarness-Setup.exe`。
3. 双击 `DeepSeekHarness-Setup.exe`。
4. 按安装向导点击“下一步”，选择安装目录。
5. 保持创建桌面快捷方式的选项。
6. 点击完成后，从桌面快捷方式或开始菜单启动 `DeepSeek Harness`。

推荐普通用户只使用 `DeepSeekHarness-Setup.exe`。它是标准安装向导，会复制程序文件、创建快捷方式，并注册卸载入口。

## 关于 API Key

不要把个人 API Key 写入 GitHub 仓库、安装包、README、Issue、Release 说明或任何会公开的配置文件。

当前公开仓库只提供 `plugin-config.example.json` 作为示例配置：

```json
{
  "imageAutoAnalysis": {
    "model": "step-3.7-flash",
    "apiKey": "",
    "baseUrl": ""
  }
}
```

图片自动分析插件的目标行为是让用户填写自己的 API，而不是使用开发者的 API。当前这个脱敏发行工程保留了示例配置和安全说明；如果要把“用户填写 API”的入口做成完整 UI，还需要在插件源码或插件配置界面里继续实现并验证。

## 开发者如何重新构建安装包

构建环境要求：

- Windows
- Node.js
- Inno Setup 6
- 可选：WiX Toolset，用于 MSI

推荐构建 Setup 安装包：

```powershell
Set-Location J:\测试\DeepSeekHarness_release_work
& "J:\innosetup\ISCC.exe" ".\packaging\DeepSeekHarness.iss"
```

生成结果：

```text
J:\测试\DeepSeekHarness_release_work\dist\DeepSeekHarness-Setup.exe
```

可选构建 MSI：

```powershell
Set-Location J:\测试\DeepSeekHarness_release_work\packaging
.\build-msi.ps1
```

当前推荐面向最终用户发布 `DeepSeekHarness-Setup.exe`，因为它的安装体验更接近普通 Windows 软件：一路下一步、自动创建快捷方式、支持卸载。

## 仓库脱敏规则

提交前必须确认不要包含以下内容：

- API Key、Access Token、Cookie、账号密码、`.env`
- WebView2 用户数据目录，例如 `EBWebView`
- 浏览器缓存、Local Storage、IndexedDB、Session Storage
- 用户日志、会话、历史记录
- 本地生成的 `dist` 安装包目录
- 不必要的第三方缓存

建议每次提交前执行一次关键词扫描，至少覆盖 `sk-`、`AIza`、`Bearer`、`API_KEY`、`TOKEN`、`SECRET` 等模式。

## License

详见 [LICENSE](LICENSE)。本仓库中的发布脚本和项目文档遵循该许可证；随包依赖的第三方组件仍遵循各自许可证和声明。
