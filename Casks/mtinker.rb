cask "mtinker" do
  version "1.5.0"
  sha256 "7cba0f70bda0bd15ed4cff71db4461effb03c21e221563a79a4ad0182ef7b859"

  url "https://github.com/mahui/mtinker-dist/releases/download/v#{version}/mTinker.dmg"
  name "mTinker"
  desc "随手把 Mac 修顺手的菜单栏小工具"
  homepage "https://mtinker.app.mahui.me/"

  auto_updates true
  depends_on macos: :ventura

  app "mTinker.app"

  zap trash: [
    "~/Library/Caches/me.mahui.app.mtinker",
    "~/Library/Preferences/me.mahui.app.mtinker.plist",
    "~/Library/Application Support/me.mahui.app.mtinker",
  ]
end
