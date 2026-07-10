cask "mtinker" do
  version "1.5.1"
  sha256 "8f539c95b59dc97431baa7b802e5bb3795b9356bb28323bf379631d79625c1cd"

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
