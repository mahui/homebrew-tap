# 模板：publish-cask.sh 用 sed 替换 1.6.0 / 69716f1caad36b345e0dc1bb71d34e942f0fd3d98eee734d115872233a87d2d2 / mahui/diskly-dist 后写入 tap 仓。
# 只引用公开发布仓与官网，绝不出现私有源码仓地址。
cask "diskly" do
  version "1.6.0"
  sha256 "69716f1caad36b345e0dc1bb71d34e942f0fd3d98eee734d115872233a87d2d2"

  url "https://github.com/mahui/diskly-dist/releases/download/v#{version}/Diskly-#{version}.dmg"
  name "Diskly"
  desc "可视化 macOS 磁盘分析与清理工具"
  homepage "https://diskly.app.mahui.me"

  # 内置自动更新；livecheck 指向官网 appcast，让 brew 不把内置自更新误判为版本不符。
  livecheck do
    url "https://diskly.app.mahui.me/appcast.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "Diskly.app"

  # 卸载时清理 app 自己写的数据；不动其它。
  zap trash: [
    "~/Library/Application Support/Diskly",
    "~/Library/Preferences/me.mahui.app.diskly.plist",
    "~/Library/Caches/me.mahui.app.diskly",
    "~/Library/Saved Application State/me.mahui.app.diskly.savedState",
  ]
end
