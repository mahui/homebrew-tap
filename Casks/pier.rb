cask "pier" do
  version "1.1.2"
  sha256 "1003ca5ade20a054b7cfba5875caf6fafa2958f539bfc9e7b5de6ecb6c721cd5"

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
