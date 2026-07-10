# mahui Homebrew Tap

用于安装和更新 mahui 发布的 macOS 应用。

| 软件 | 用途 | 最低系统 | 官网 |
| --- | --- | --- | --- |
| Pier | 查看端口、进程和系统资源的菜单栏工具 | macOS 14 Sonoma | <https://pier.app.mahui.me/> |
| Diskly | 可视化磁盘分析与清理工具 | macOS 14 Sonoma | <https://diskly.app.mahui.me/> |
| mTinker | 系统修复与剪贴板历史菜单栏工具 | macOS 13 Ventura | <https://mtinker.app.mahui.me/> |

## 安装

直接安装指定应用：

```bash
brew install --cask mahui/tap/pier
brew install --cask mahui/tap/diskly
brew install --cask mahui/tap/mtinker
```

也可以先添加 Tap，再使用短名称：

```bash
brew tap mahui/tap
brew install --cask pier
```

## 升级

三个应用都带有内置自动更新，因此 Homebrew 默认可能跳过它们。若要明确通过 Homebrew 检查并升级，可使用 `--greedy`：

```bash
brew update
brew upgrade --cask --greedy pier diskly mtinker
```

## 卸载

```bash
brew uninstall --cask pier
brew uninstall --cask --zap pier
```

`--zap` 会额外清理应用的偏好和缓存。Pier 的许可证保存在钥匙串中，不会被其 `zap` 配置删除。

## 排障

```bash
brew update
brew info --cask mahui/tap/pier
brew reinstall --cask mahui/tap/pier
brew doctor
```

如果 Homebrew 仍在读取旧 Cask，可先执行 `brew update`，再用完整名称 `mahui/tap/<软件名>` 重试。

## 维护

仓库职责、发版脚本约束和校验命令见 [MAINTAINING.md](MAINTAINING.md)。
