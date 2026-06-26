cask "mtinker" do
  version "1.0.0"
  sha256 "1c5a3edcd32c2e9248374fa68d0ad39c71f30de456a5b6a0bdbff5da12d970a9"

  url "https://github.com/mahui/mtinker-dist/releases/download/v#{version}/mTinker.dmg"
  name "mTinker"
  desc "随手把 Mac 修顺手的菜单栏小工具"
  homepage "https://mtinker.app.mahui.me/"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "mTinker.app"

  zap trash: [
    "~/Library/Caches/me.mahui.app.mtinker",
    "~/Library/Preferences/me.mahui.app.mtinker.plist",
    "~/Library/Application Support/me.mahui.app.mtinker",
  ]
end
