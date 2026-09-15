cask "mtinker" do
  version "2.1.0"
  sha256 "10e1d8cd75513d663194ebd6b32a3a74f41950d8d1f67c657ab4d704b9901761"

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
