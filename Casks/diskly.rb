cask "diskly" do
  version "2.0.1"
  sha256 "9d5a63d1e9d957c972dd82f9ae3774df75b1be5cf91fda503c4240fcdc94d0ae"

  url "https://github.com/mahui/diskly-dist/releases/download/v#{version}/Diskly-#{version}.dmg",
      verified: "github.com/mahui/diskly-dist/"
  name "Diskly"
  desc "Visual disk analyzer and cleanup tool"
  homepage "https://diskly.app.mahui.me/"

  # 内置自动更新；livecheck 指向官网 appcast，让 brew 不把内置自更新误判为版本不符。
  livecheck do
    url "https://diskly.app.mahui.me/appcast.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Diskly.app"

  # 卸载时清理 app 自己写的数据；不动其它。
  zap trash: [
    "~/Library/Application Support/Diskly",
    "~/Library/Caches/me.mahui.app.diskly",
    "~/Library/Preferences/me.mahui.app.diskly.plist",
    "~/Library/Saved Application State/me.mahui.app.diskly.savedState",
  ]
end
