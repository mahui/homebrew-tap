# Tap 维护说明

## 单一事实来源

本仓库是三个软件包完整 Cask 和 Tap README 的唯一事实来源。各应用主仓库只负责构建、签名、公证和发布 DMG；发布脚本克隆本 Tap 后，只能修改对应 Cask 的以下字段：

- `version`
- `sha256`
- URL 与 `verified:` 中的公开发布仓地址

上游仓库不得保存第二份完整 Cask，不得复制或覆盖本仓库的 README。

## 发版顺序

每个应用继续遵循：

1. 构建、签名和公证应用及 DMG。
2. 运行应用仓库的 Cask 发布或更新脚本。
3. 确认公开 Release 和 Tap Cask 已就位。
4. 最后更新 appcast 并部署官网。

Tap 中 `scripts/update-cask.rb` 负责校验版本、SHA-256、发布仓格式和替换次数。上游脚本还必须确认 Tap remote、`main` 分支、Ruby 语法、Homebrew 样式和实际变更文件范围。

## 本地校验

```bash
ruby test/update_cask_test.rb
ruby test/cask_contract_test.rb
ruby -c Casks/pier.rb
ruby -c Casks/diskly.rb
ruby -c Casks/mtinker.rb
brew style Casks/pier.rb Casks/diskly.rb Casks/mtinker.rb
brew ruby scripts/audit-casks.rb Casks/pier.rb Casks/diskly.rb Casks/mtinker.rb
git diff --check
```

## 新增 Cask

1. 直接在本仓库新增 `Casks/<token>.rb`，补齐 `verified:`、最低系统、`livecheck`、`auto_updates` 和 `zap`。
2. 为 `test/cask_contract_test.rb` 增加元数据契约。
3. 在应用发布脚本中调用 `scripts/update-cask.rb`，不要生成完整 heredoc 或复制模板。
4. 先让 Tap 的测试、style 和 audit 全部通过，再启用应用发布脚本。
5. README 只在本仓库维护，新增软件时同步更新软件表格。

## 公开内容约束

Tap、公开发布仓和 Release notes 只引用公开官网、公开下载地址与 Homebrew 命令，不写入私有源码地址、凭据或本地发布配置。
