# Dotfiles Setup

Managed with [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

### 1. Install Dependencies
**Linux (Debian/Ubuntu):**
```bash
apt update && apt install -y curl
```

### 2. Apply Dotfiles
Run the following one-liner to initialize and apply the configuration:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Yutosaki
```

### 3. GitHub CLI Authentication
Required for Neovim Pull Request review features.

Run the following command:
```bash
gh auth login
```

Follow these steps:
1. What account do you want to log into? -> Select 'GitHub.com'
2. What is your preferred protocol for Git operations? -> Select 'HTTPS'
3. Authenticate Git with your GitHub credentials? -> Select 'Yes'
4. How would you like to authenticate GitHub CLI? -> Select 'Login with a web browser'
5. Copy the one-time code, press Enter, and complete the authentication in your browser.```

This is the complete content for your README.md. You can copy the code block below entirely and paste it into your file.

## 🍎 macOS Users

### ⚠️ Karabiner-Elements Installation
Automated installation of Karabiner-Elements is not supported due to password/security prompts. Please install it manually:

```bash
brew install --cask karabiner-elements
```
After installation, open the app and follow the system prompts to allow input monitoring.

## 🌐 Browser Extensions (Vimium)
Auto-sync is not possible for browser extensions. You need to import settings manually.

1. Locate the config file in your chezmoi source directory (e.g., `~/.local/share/chezmoi/vimium/vimium-options.json`).
2. Open Vimium Options in your browser.
3. Click **"Restore selected settings from a file"**.
4. Upload the json file.

## 🔧 Troubleshooting
### `bat` error (Rust binary)
If you encounter the following error:
> `zsh: no such file or directory: .../bat/target/release/bat`

It means the `bat` binary needs to be built from source. Run these commands inside the chezmoi source directory:

```bash
cd ~/.local/share/chezmoi/bat
cargo build --release
```

## 📦 Optional Setup

### Multipass
If you want to use **Multipass**, you need to configure the initialization file:

1. Go to the multipass directory in chezmoi source.
2. Rename `init.yaml.template` to `init.yaml`.
3. Open `init.yaml` and paste your **SSH Public Key**.

```bash
cd ~/.local/share/chezmoi/multipass
mv init.yaml.template init.yaml
# Then edit init.yaml
```
Then edit init.yaml
