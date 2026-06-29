cask "mtinker" do
  version "1.3.0"
  sha256 "78fe5067f3fff472ea09920bf8fec4bedfa858830e7bf84cef7cbf632bc56f0d"

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
