param(
  [string]$InstallDir = "$env:LOCALAPPDATA\Programs\DeepSeekHarness",
  [switch]$Interactive
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$payloadZip = Join-Path $scriptDir "DeepSeekHarness-portable.zip"

if (-not (Test-Path -LiteralPath $payloadZip)) {
  throw "Payload zip not found: $payloadZip"
}

if ($Interactive) {
  Add-Type -AssemblyName System.Windows.Forms
  $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
  $dialog.Description = "选择 DeepSeek Harness 的安装位置"
  $dialog.SelectedPath = $InstallDir
  $dialog.ShowNewFolderButton = $true
  if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    exit 2
  }
  $InstallDir = $dialog.SelectedPath
}

New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
Expand-Archive -LiteralPath $payloadZip -DestinationPath $InstallDir -Force

$desktop = [Environment]::GetFolderPath("Desktop")
$shortcutPath = Join-Path $desktop "DeepSeek Harness.lnk"
$targetPath = Join-Path $InstallDir "Harness.exe"

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $targetPath
$shortcut.WorkingDirectory = $InstallDir
$shortcut.Description = "DeepSeek Harness"
$shortcut.Save()

Write-Host "Installed DeepSeek Harness to $InstallDir"
Write-Host "Shortcut created at $shortcutPath"

if ($Interactive) {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.MessageBox]::Show("DeepSeek Harness 安装完成。`n`n安装位置：$InstallDir", "DeepSeek Harness", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) | Out-Null
}
