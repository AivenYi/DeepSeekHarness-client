# Release Checklist

- [ ] Confirm the release contains no personal API key or token.
- [ ] Exclude `Harness.exe.WebView2` and all WebView profile data.
- [ ] Exclude `.env`, credentials, sessions, and user profiles.
- [ ] Build `DeepSeekHarness-Setup.exe` with the standard installer wizard.
- [ ] Test install, desktop shortcut, launch, and uninstall on a clean Windows account.
- [ ] Upload the installer as a GitHub Release asset.
- [ ] Keep API configuration user-owned and outside committed files.
