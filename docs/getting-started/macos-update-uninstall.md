# macOS Update and Uninstall Guide

This page documents supported update and uninstall procedures for SiriClaw on macOS (OS X).

Last verified: **February 22, 2026**.

## 1) Check current install method

```bash
which siriusclaw
siriusclaw --version
```

Typical locations:

- Homebrew: `/opt/homebrew/bin/siriusclaw` (Apple Silicon) or `/usr/local/bin/siriusclaw` (Intel)
- Cargo/bootstrap/manual: `~/.cargo/bin/siriusclaw`

If both exist, your shell `PATH` order decides which one runs.

## 2) Update on macOS

### A) Homebrew install

```bash
brew update
brew upgrade siriusclaw
siriusclaw --version
```

### B) Clone + bootstrap install

From your local repository checkout:

```bash
git pull --ff-only
./bootstrap.sh --prefer-prebuilt
siriusclaw --version
```

If you want source-only update:

```bash
git pull --ff-only
cargo install --path . --force --locked
siriusclaw --version
```

### C) Manual prebuilt binary install

Re-run your download/install flow with the latest release asset, then verify:

```bash
siriusclaw --version
```

## 3) Uninstall on macOS

### A) Stop and remove background service first

This prevents the daemon from continuing to run after binary removal.

```bash
sirius service stop || true
sirius service uninstall || true
```

Service artifacts removed by `service uninstall`:

- `~/Library/LaunchAgents/com.siriusclaw.daemon.plist`

### B) Remove the binary by install method

Homebrew:

```bash
brew uninstall siriusclaw
```

Cargo/bootstrap/manual (`~/.cargo/bin/siriusclaw`):

```bash
cargo uninstall siriusclaw || true
rm -f ~/.cargo/bin/siriusclaw
```

### C) Optional: remove local runtime data

Only run this if you want a full cleanup of config, auth profiles, logs, and workspace state.

```bash
rm -rf ~/.siriusclaw
```

## 4) Verify uninstall completed

```bash
command -v siriusclaw || echo "siriusclaw binary not found"
pgrep -fl siriusclaw || echo "No running siriusclaw process"
```

If `pgrep` still finds a process, stop it manually and re-check:

```bash
pkill -f siriusclaw
```

## Related docs

- [One-Click Bootstrap](../one-click-bootstrap.md)
- [Commands Reference](../commands-reference.md)
- [Troubleshooting](../troubleshooting.md)
