param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$Dist = (Join-Path $Root "dist")
)

$ErrorActionPreference = "Stop"

New-Item -ItemType Directory -Path $Dist -Force | Out-Null

$buildTemp = Join-Path $Dist "temp"
New-Item -ItemType Directory -Path $buildTemp -Force | Out-Null
$env:TEMP = $buildTemp
$env:TMP = $buildTemp

$zipPath = Join-Path $Dist "DeepSeekHarness-portable.zip"
$setupExe = Join-Path $Dist "DeepSeekHarness-Setup.exe"
$installScript = Join-Path $PSScriptRoot "install.ps1"
$sedPath = Join-Path $Dist "DeepSeekHarness-Setup.sed"

$runtimeConfig = Join-Path $Root "plugin-config.example.json"
@'
{
  "imageAutoAnalysis": {
    "model": "step-3.7-flash",
    "apiKey": "",
    "baseUrl": ""
  }
}
'@ | Set-Content -LiteralPath $runtimeConfig -Encoding UTF8

if (Test-Path -LiteralPath $zipPath) {
  Remove-Item -LiteralPath $zipPath -Force
}
if (Get-Command tar.exe -ErrorAction SilentlyContinue) {
  Push-Location $Root
  try {
    tar.exe -a -cf $zipPath Harness.exe node_modules plugin-config.example.json
  } finally {
    Pop-Location
  }
} else {
  Compress-Archive -Path (Join-Path $Root "Harness.exe"), (Join-Path $Root "node_modules"), $runtimeConfig -DestinationPath $zipPath -CompressionLevel Optimal
}

$iexpressStage = Join-Path $Dist "iexpress-stage"
if (Test-Path -LiteralPath $iexpressStage) {
  Remove-Item -LiteralPath $iexpressStage -Recurse -Force
}
New-Item -ItemType Directory -Path $iexpressStage -Force | Out-Null
Copy-Item -LiteralPath $zipPath -Destination (Join-Path $iexpressStage "DeepSeekHarness-portable.zip") -Force
Copy-Item -LiteralPath $installScript -Destination (Join-Path $iexpressStage "install.ps1") -Force

$stageEscaped = $iexpressStage -replace '\\', '\\'
$setupEscaped = $setupExe -replace '\\', '\\'

@"
[Version]
Class=IEXPRESS
SEDVersion=3
[Options]
PackagePurpose=InstallApp
ShowInstallProgramWindow=0
HideExtractAnimation=1
UseLongFileName=1
InsideCompressed=0
CAB_FixedSize=0
CAB_ResvCodeSigning=0
RebootMode=N
InstallPrompt=
DisplayLicense=
FinishMessage=DeepSeek Harness setup finished.
TargetName=$setupEscaped
FriendlyName=DeepSeek Harness Setup
AppLaunched=powershell.exe -NoProfile -ExecutionPolicy Bypass -File install.ps1
PostInstallCmd=<None>
AdminQuietInstCmd=powershell.exe -NoProfile -ExecutionPolicy Bypass -File install.ps1
UserQuietInstCmd=powershell.exe -NoProfile -ExecutionPolicy Bypass -File install.ps1
SourceFiles=SourceFiles
[Strings]
FILE0=DeepSeekHarness-portable.zip
FILE1=install.ps1
[SourceFiles]
SourceFiles0=$stageEscaped
[SourceFiles0]
%FILE0%=
%FILE1%=
"@ | Set-Content -LiteralPath $sedPath -Encoding ASCII

if (Get-Command iexpress.exe -ErrorAction SilentlyContinue) {
  iexpress.exe /N /Q $sedPath
} else {
  Write-Warning "iexpress.exe not found; Setup.exe was not generated."
}

Write-Host "Portable package: $zipPath"
if (Test-Path -LiteralPath $setupExe) {
  Write-Host "Setup package: $setupExe"
}
