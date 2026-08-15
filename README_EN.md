# DeepSeek Harness client

[![Platform](https://img.shields.io/badge/platform-Windows-0078D4?logo=windows&logoColor=white)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![Installer](https://img.shields.io/badge/installer-Setup.exe-2EA44F)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![Release](https://img.shields.io/github/v/release/AivenYi/DeepSeekHarness?include_prereleases&label=release)](https://github.com/AivenYi/DeepSeekHarness/releases)
[![License](https://img.shields.io/github/license/AivenYi/DeepSeekHarness)](LICENSE)
[![Security](https://img.shields.io/badge/security-no%20keys%20committed-critical)](SECURITY.md)
[![WebView2](https://img.shields.io/badge/runtime-WebView2-5C2D91)](https://developer.microsoft.com/microsoft-edge/webview2/)
[![DeepSeek](https://img.shields.io/badge/model-DeepSeek-4B6BFB)](https://www.deepseek.com/)

Chinese documentation: [README.md](README.md)

DeepSeek Harness is a Windows desktop client for end users. Users do not need to unpack a zip file or run command-line scripts. They can download `DeepSeekHarness-Setup.exe`, double-click it, and complete installation through a normal setup wizard.

The goal is straightforward: make DeepSeek easier to use. DeepSeek primarily provides a web experience, while this project packages an already built DeepSeek Harness distribution into a desktop installer. It also documents an important extension direction: users should be able to upload images during chat, let an image auto-analysis plugin process the image, and then continue the conversation with DeepSeek models.

> This repository is a sanitized Windows release workspace. It is not the official DeepSeek project and is not the full upstream source tree of DeepSeek Harness.

## Direct Download

End users should download this installer:

[Download DeepSeekHarness-Setup.exe](https://github.com/AivenYi/DeepSeekHarness/releases/download/v1.0.0-windows/DeepSeekHarness-Setup.exe)

Alternative links:

- [GitHub Release page](https://github.com/AivenYi/DeepSeekHarness/releases/tag/v1.0.0-windows)
- [All Releases](https://github.com/AivenYi/DeepSeekHarness/releases)

After downloading, double-click `DeepSeekHarness-Setup.exe` and follow the wizard. After installation, launch `DeepSeek Harness` from the desktop shortcut or Start menu.

## Source And Attribution

- DeepSeek brand, models, and services come from DeepSeek: [https://www.deepseek.com/](https://www.deepseek.com/)
- The desktop window depends on Microsoft Edge WebView2: [https://developer.microsoft.com/microsoft-edge/webview2/](https://developer.microsoft.com/microsoft-edge/webview2/)
- This repository was prepared from an already packaged DeepSeek Harness Windows build and references a lighter Rust/WebView2 launcher approach for installer organization.
- This repository keeps installer scripts, release documentation, example configuration, and sanitized release notes only. It must not contain personal API keys, cookies, browser caches, or user session data.

## Purpose

The DeepSeek web interface is useful, but many users prefer a desktop application that can be installed and launched like normal Windows software. This project wraps the existing web-based experience into a Windows desktop installer to reduce friction.

Another goal is to improve multimodal workflows. During chat, users should be able to upload an image, let the image auto-analysis plugin process it first, and then pass the result into the DeepSeek conversation.

## Installation

1. Click [Download DeepSeekHarness-Setup.exe](https://github.com/AivenYi/DeepSeekHarness/releases/download/v1.0.0-windows/DeepSeekHarness-Setup.exe).
2. Download `DeepSeekHarness-Setup.exe`.
3. Double-click `DeepSeekHarness-Setup.exe`.
4. Follow the setup wizard and choose an installation directory.
5. Keep the desktop shortcut option enabled.
6. Launch `DeepSeek Harness` from the desktop shortcut or Start menu.

The recommended end-user package is `DeepSeekHarness-Setup.exe`. It provides a standard wizard, file installation, shortcut creation, and uninstall registration.

## API Key Safety

Do not put personal API keys in this repository, installer, README files, Issues, Release notes, or any public configuration file.

The repository includes `plugin-config.example.json` only as an example:

```json
{
  "imageAutoAnalysis": {
    "model": "step-3.7-flash",
    "apiKey": "",
    "baseUrl": ""
  }
}
```

The intended behavior for the image auto-analysis plugin is that users provide their own API key instead of using the developer's key. This sanitized release workspace includes the example configuration and safety documentation. A complete in-app API entry UI still needs to be implemented and verified in the plugin source or plugin configuration interface.

## Rebuilding The Installer

Build requirements:

- Windows
- Node.js
- Inno Setup 6
- Optional: WiX Toolset for MSI output

Recommended Setup installer build:

```powershell
Set-Location J:\测试\DeepSeekHarness_release_work
& "J:\innosetup\ISCC.exe" ".\packaging\DeepSeekHarness.iss"
```

Output:

```text
J:\测试\DeepSeekHarness_release_work\dist\DeepSeekHarness-Setup.exe
```

Optional MSI build:

```powershell
Set-Location J:\测试\DeepSeekHarness_release_work\packaging
.\build-msi.ps1
```

For end users, `DeepSeekHarness-Setup.exe` is the recommended release artifact because it behaves like a normal Windows installer.

## Repository Hygiene

Before committing, make sure the repository does not contain:

- API keys, access tokens, cookies, credentials, or `.env` files
- WebView2 user data such as `EBWebView`
- Browser cache, Local Storage, IndexedDB, or Session Storage
- User logs, sessions, or history
- Local generated `dist` artifacts
- Unnecessary third-party caches

Run a secret scan before every push. At minimum, scan for `sk-`, `AIza`, `Bearer`, `API_KEY`, `TOKEN`, and `SECRET`.

## License

See [LICENSE](LICENSE). The release scripts and project documentation in this repository are covered by that license. Bundled third-party components keep their own licenses and notices.
