cask "mtinker" do
  version "2.0.0"
  sha256 "e7eade1f4e3d000ab66ba7802102534f0ba1af0f44ffb5c1399c35fbee5d004e"

  url "https://github.com/mahui/mtinker-dist/releases/download/v#{version}/mTinker.dmg",
      verified: "github.com/mahui/mtinker-dist/"
  name "mTinker"
  desc "Menu bar toolkit for system fixes and clipboard history"
  homepage "https://mtinker.app.mahui.me/"

  auto_updates true
  depends_on macos: :ventura

  app "mTinker.app"

  zap trash: [
    "~/Library/Application Support/me.mahui.app.mtinker",
    "~/Library/Caches/me.mahui.app.mtinker",
    "~/Library/Preferences/me.mahui.app.mtinker.plist",
  ]
end
