# frozen_string_literal: true

require "minitest/autorun"

class CaskContractTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  EXPECTED = {
    "pier" => {
      desc: "Menu bar app to inspect ports, processes and system resources",
      homepage: "https://pier.app.mahui.me/",
      macos: ":sonoma",
      repository: "mahui/pier-dist",
    },
    "diskly" => {
      desc: "Visual disk analyzer and cleanup tool",
      homepage: "https://diskly.app.mahui.me/",
      macos: ":sonoma",
      repository: "mahui/diskly-dist",
    },
    "mtinker" => {
      desc: "Menu bar toolkit for system fixes and clipboard history",
      homepage: "https://mtinker.app.mahui.me/",
      macos: ":ventura",
      repository: "mahui/mtinker-dist",
    },
  }.freeze

  def test_cask_metadata_contract
    EXPECTED.each do |token, expected|
      content = File.read(File.join(ROOT, "Casks", "#{token}.rb"))

      assert_includes content, %(desc "#{expected[:desc]}")
      assert_includes content, %(homepage "#{expected[:homepage]}")
      assert_includes content, %(depends_on macos: #{expected[:macos]})
      assert_includes content, %(verified: "github.com/#{expected[:repository]}/")
      refute_match(/depends_on\s+macos:\s*["']/, content)

      zap_entries = content.scan(/^\s+"~\/Library\/[^"]+",$/).map(&:strip)
      assert_equal zap_entries.sort, zap_entries, "#{token} 的 zap 条目必须按字母排序"
    end
  end
end
