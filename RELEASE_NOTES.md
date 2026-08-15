# DeepSeek Harness Release Work

This directory is a copied release workspace. The original package at `J:\测试\DeepSeekHarness` was not modified.

## Generated Packages

- `dist\DeepSeekHarness-portable.zip`: portable Windows package containing `Harness.exe`, `node_modules`, and `plugin-config.example.json`.
- `dist\DeepSeekHarness-SetupPayload.cab`: Windows setup payload containing the portable ZIP and installer script. IExpress did not emit a final `Setup.exe` on this machine.

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\packaging\build-release.ps1
```

## MSI

This machine does not currently have WiX Toolset, MSBuild, or another MSI builder on PATH. Generate MSI from the same portable payload after installing WiX or building on CI. The MSI should install the ZIP payload to the selected install directory and create a shortcut to `Harness.exe`.

## APK and macOS

The current app is a Windows Rust WebView2 shell around a Node service. APK and macOS packages require platform-specific application shells:

- Android: a native Android/WebView or Tauri mobile wrapper, plus Node-compatible backend strategy.
- macOS: build the Rust shell on macOS with a macOS WebView backend and package as `.app`/`.dmg`/`.pkg`.

They cannot be produced correctly from this Windows-only binary alone.

## Image Auto Analysis API Configuration

The copied package did not contain a clearly identifiable `step 3.7 flash` image auto-analysis plugin implementation. A placeholder user configuration file is included in the portable payload:

```json
{
  "imageAutoAnalysis": {
    "model": "step-3.7-flash",
    "apiKey": "",
    "baseUrl": ""
  }
}
```

When the plugin source or exact package path is available, wire the plugin to read `imageAutoAnalysis.apiKey` and require users to provide their own key instead of embedding a developer key.

## GitHub Sanitization

Before pushing, exclude runtime data and generated artifacts:

- `Harness.exe.WebView2/`
- `dist/`
- logs, local profiles, and any API keys
- `node_modules/` unless this repository intentionally vendors the runtime
