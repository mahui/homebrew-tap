# Pier Homebrew Tap

[Pier](https://pier.app.mahui.me/) 的 Homebrew tap —— 驻留 macOS 菜单栏的轻量端口 / 进程 / 系统资源查看工具。

## 安装

```bash
brew install --cask mahui/tap/pier
```

或分两步：

```bash
brew tap mahui/tap
brew install --cask pier
```

## 升级 / 卸载

```bash
brew upgrade --cask pier      # Pier 也内置自动更新
brew uninstall --cask pier    # 加 --zap 一并清除偏好与缓存
```

> 这个仓库的 `Casks/pier.rb` 由 Pier 主仓库的 `scripts/publish-cask.sh` 在每次发布时自动更新，请勿手动改动。
