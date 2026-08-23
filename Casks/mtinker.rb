cask "mtinker" do
  version "1.6.0"
  sha256 "66b1301323b447f836d1c52b44935725a96b95b1616fec06a4e5e25b84c8465c"

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
