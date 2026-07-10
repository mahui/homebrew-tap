# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"
require_relative "../scripts/update-cask"

class UpdateCaskTest < Minitest::Test
  SHA256 = "a" * 64

  def setup
    @root = Dir.mktmpdir("update-cask-test")
    FileUtils.mkdir_p(File.join(@root, "Casks"))
    @path = File.join(@root, "Casks", "sample.rb")
    File.write(@path, <<~RUBY)
      cask "sample" do
        version "1.0.0"
        sha256 "#{"0" * 64}"

        url "https://github.com/example/sample-dist/releases/download/v\#{version}/Sample.dmg",
            verified: "github.com/example/sample-dist/"
        name "Sample"
        desc "Metadata must remain unchanged"
      end
    RUBY
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def test_updates_only_release_fields
    path = CaskUpdater.new(root: @root).update(
      token: "sample",
      version: "2.1.3",
      sha256: SHA256,
      repository: "mahui/sample-dist",
    )

    content = File.read(path)
    assert_includes content, 'version "2.1.3"'
    assert_includes content, %(sha256 "#{SHA256}")
    assert_equal 2, content.scan("github.com/mahui/sample-dist").length
    assert_includes content, 'desc "Metadata must remain unchanged"'
  end

  def test_rejects_invalid_inputs
    updater = CaskUpdater.new(root: @root)

    assert_raises(ArgumentError) do
      updater.update(token: "../sample", version: "2.0", sha256: SHA256, repository: "mahui/sample-dist")
    end
    assert_raises(ArgumentError) do
      updater.update(token: "sample", version: "v2", sha256: SHA256, repository: "mahui/sample-dist")
    end
    assert_raises(ArgumentError) do
      updater.update(token: "sample", version: "2.0", sha256: "bad", repository: "mahui/sample-dist")
    end
    assert_raises(ArgumentError) do
      updater.update(token: "sample", version: "2.0", sha256: SHA256, repository: "sample-dist")
    end
  end

  def test_requires_exactly_two_repository_references
    content = File.read(@path).sub(/^\s+verified:.*\n/, "")
    File.write(@path, content)

    assert_raises(ArgumentError) do
      CaskUpdater.new(root: @root).update(
        token: "sample",
        version: "2.0",
        sha256: SHA256,
        repository: "mahui/sample-dist",
      )
    end
  end

  def test_script_parses_with_system_ruby
    system_ruby = "/usr/bin/ruby"
    skip "system Ruby is unavailable" unless File.executable?(system_ruby)

    script = File.expand_path("../scripts/update-cask.rb", __dir__)
    stdout, stderr, status = Open3.capture3(system_ruby, "-c", script)

    assert status.success?, stdout + stderr
  end
end
