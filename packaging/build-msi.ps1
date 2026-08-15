param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)
$ErrorActionPreference = "Stop"
$wix = "J:\wix311"
$obj = Join-Path $Root "dist\msi-obj"
$wxs = Join-Path $PSScriptRoot "DeepSeekHarness.wxs"
New-Item -ItemType Directory -Path $obj -Force | Out-Null
Push-Location $PSScriptRoot
try {
& (Join-Path $wix "candle.exe") -nologo -out (Join-Path $obj "DeepSeekHarness.wixobj") $wxs
if ($LASTEXITCODE -ne 0) { throw "candle failed" }
& (Join-Path $wix "light.exe") -nologo -sice:ICE38 -sice:ICE64 -ext WixUtilExtension -out (Join-Path $Root "dist\DeepSeekHarness.msi") (Join-Path $obj "DeepSeekHarness.wixobj")
if ($LASTEXITCODE -ne 0) { throw "light failed" }
} finally { Pop-Location }
Write-Host "MSI: $(Join-Path $Root 'dist\DeepSeekHarness.msi')"
