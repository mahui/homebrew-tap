cask "mtinker" do
  version "1.1.0"
  sha256 "8d5a67e94ac9901e35632794bfb5cd6b717bebe0c125a8fd57b0af55ece3ef44"

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
