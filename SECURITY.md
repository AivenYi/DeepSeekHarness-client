# Security Policy

Do not report API keys, cookies, session files, or other credentials in a public issue.

If you believe a release contains a secret:

1. Stop using the affected key immediately.
2. Revoke or rotate the key at the provider.
3. Contact the repository maintainer privately with the release version and file path.

Before publishing a release, inspect the package and WebView data for credentials and run a secret scanner over the files being committed.
