cask "mtinker" do
  version "1.7.0"
  sha256 "c03da282d8ddb2b025d1762b2dbfc9bcb4dc44cdb858b2f0cae65b16bbdbedf3"

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
