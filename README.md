# DeepSeek Harness

DeepSeek Harness is a local desktop application that starts the DeepSeek Harness web interface and opens it in a Windows WebView2 window.

The repository is published as a prebuilt Windows release. The source package currently available to this project is a packaged distribution, so the repository does not claim to be the upstream DeepSeek Harness source tree.

## Installation

1. Download `DeepSeekHarness-Setup.exe` from the GitHub Releases page.
2. Double-click the installer.
3. Follow the wizard and choose an installation directory.
4. Keep the option to create a desktop shortcut enabled.
5. Launch `DeepSeek Harness` from the desktop or Start menu.

The installer copies the application executable and its local Node.js dependencies. The application requires Windows WebView2 and a supported Node.js runtime. The packaged Windows launcher uses the local runtime configuration shipped with the release.

## First-run configuration

Do not put a personal API key in this repository, in the installer, or in a committed configuration file.

The release includes `plugin-config.example.json` only as a configuration reference. It contains an empty key:

```json
{
  "imageAutoAnalysis": {
    "model": "step-3.7-flash",
    "apiKey": "",
    "baseUrl": ""
  }
}
```

The current packaged build does not yet expose a verified image-analysis API form in its UI. Until that integration is completed, do not assume that image auto-analysis is safe to publish as a user-configurable feature. Treat API keys as secrets and store them only in the application's local user configuration or an environment variable supported by the plugin.

## Building the Windows installer

The build scripts must be run from a Windows machine with Node.js installed. Build tools are intentionally kept outside the repository.

```powershell
Set-Location .\packaging
.\build-release.ps1
```

The release installer is built with Inno Setup:

```powershell
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" .\DeepSeekHarness.iss
```

The resulting installer is written to `dist\DeepSeekHarness-Setup.exe`.

The WiX script in `packaging\build-msi.ps1` is retained as an optional MSI build path. The recommended end-user package is the Inno Setup installer because it provides a standard wizard, uninstall registration, shortcut creation, and reliable file extraction.

## Repository hygiene

Do not commit any of the following:

- API keys, access tokens, cookies, credentials, or `.env` files
- WebView2 profile data, browser caches, `EBWebView`, `profiles`, or `sessions`
- User-specific logs or generated configuration
- Unpacked release staging directories
- Third-party dependency caches that are not required by the release

Run a secret scan before every push. A release build should contain only the executable, required runtime dependencies, public example configuration, installer scripts, and documentation.

## License

See `LICENSE` for the license applying to the release scripts and project-specific files. Bundled third-party packages retain their own licenses and notices.
