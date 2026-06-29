cask "mtinker" do
  version "1.2.0"
  sha256 "08fad78da0389a4467516a0d3b3f6a889fc47c2dd6516f0b9d279c9109836e1e"

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
