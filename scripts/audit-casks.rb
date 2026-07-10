#!/usr/bin/env ruby
# frozen_string_literal: true

require "cask/cask_loader"
require "cask/auditor"

if ARGV.empty?
  warn "用法：brew ruby scripts/audit-casks.rb <cask.rb> [...]"
  exit 1
end

failed = false
ARGV.each do |path|
  cask = Cask::CaskLoader::FromPathLoader.new(path).load(config: nil)
  errors = Cask::Auditor.audit(cask, audit_strict: true, any_named_args: true).to_a
  if errors.empty?
    puts "✓ #{path}"
    next
  end

  failed = true
  errors.each { |error| warn "#{path}: #{error[:message]}" }
end

exit(failed ? 1 : 0)
