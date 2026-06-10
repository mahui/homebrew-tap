cask "pier" do
  version "1.3.1"
  sha256 "3177cd162312067ad4654a77aa0f1d21de8198a65760801f8b69b613bb6d3030"

  url "https://github.com/mahui/pier-dist/releases/download/v#{version}/Pier-#{version}.dmg",
      verified: "github.com/mahui/pier-dist/"
  name "Pier"
  desc "Menu bar app to inspect ports, processes and system resources"
  homepage "https://pier.app.mahui.me/"

  # 版本探测：复用官网的 Sparkle appcast（make release 时更新）
  livecheck do
    url "https://pier.app.mahui.me/appcast.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true              # Pier 内置 Sparkle 自更新，brew 不应判定为版本不符
  depends_on macos: ">= :sonoma" # LSMinimumSystemVersion 14.0

  app "Pier.app"

  # 许可证存于钥匙串（service: me.mahui.app.pier），刻意不在 zap 中清除：
  # 卸载后重装仍保留授权状态。
  zap trash: [
    "~/Library/Preferences/me.mahui.app.pier.plist",
    "~/Library/Caches/me.mahui.app.pier",
    "~/Library/HTTPStorages/me.mahui.app.pier",
    "~/Library/Saved Application State/me.mahui.app.pier.savedState",
  ]
end
