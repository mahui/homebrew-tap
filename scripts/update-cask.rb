#!/usr/bin/env ruby
# frozen_string_literal: true

class CaskUpdater
  TOKEN_PATTERN = /\A[a-z0-9][a-z0-9+_.-]*\z/
  VERSION_PATTERN = /\A\d+(?:\.\d+){1,2}\z/
  SHA256_PATTERN = /\A[0-9a-f]{64}\z/
  REPOSITORY_PATTERN = %r{\A[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+\z}
  GITHUB_REPOSITORY_PATTERN = %r{github\.com/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+}

  def initialize(root: File.expand_path("..", __dir__))
    @root = root
  end

  def update(token:, version:, sha256:, repository:)
    validate!(token:, version:, sha256:, repository:)

    path = File.join(@root, "Casks", "#{token}.rb")
    raise ArgumentError, "Cask 不存在：#{path}" unless File.file?(path)

    content = File.read(path)
    content = replace_exact(
      content,
      /^  version "[^"]+"$/,
      %(  version "#{version}"),
      "version",
      expected: 1,
    )
    content = replace_exact(
      content,
      /^  sha256 "[0-9a-f]+"$/,
      %(  sha256 "#{sha256}"),
      "sha256",
      expected: 1,
    )
    content = replace_exact(
      content,
      GITHUB_REPOSITORY_PATTERN,
      "github.com/#{repository}",
      "GitHub 发布仓地址",
      expected: 2,
    )

    File.write(path, content)
    path
  end

  private

  def validate!(token:, version:, sha256:, repository:)
    raise ArgumentError, "无效 Cask token：#{token}" unless TOKEN_PATTERN.match?(token)
    raise ArgumentError, "无效版本号：#{version}" unless VERSION_PATTERN.match?(version)
    raise ArgumentError, "无效 SHA-256：必须是 64 位小写十六进制" unless SHA256_PATTERN.match?(sha256)
    raise ArgumentError, "无效发布仓：#{repository}" unless REPOSITORY_PATTERN.match?(repository)
  end

  def replace_exact(content, pattern, replacement, label, expected:)
    actual = content.scan(pattern).length
    unless actual == expected
      raise ArgumentError, "#{label} 应匹配 #{expected} 次，实际匹配 #{actual} 次"
    end

    content.gsub(pattern, replacement)
  end
end

if $PROGRAM_NAME == __FILE__
  unless ARGV.length == 4
    warn "用法：ruby scripts/update-cask.rb <token> <version> <sha256> <owner/repo>"
    exit 1
  end

  token, version, sha256, repository = ARGV
  begin
    path = CaskUpdater.new.update(token:, version:, sha256:, repository:)
    puts "✓ 已更新 #{path}"
  rescue ArgumentError => e
    warn "✗ #{e.message}"
    exit 1
  end
end
