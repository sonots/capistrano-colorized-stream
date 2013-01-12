#! /usr/bin/env gem build
# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name = 'capistrano-colorized-stream'
  gem.version = '0.2.1'
  gem.authors = %w(Naotoshi Seo)
  gem.email = %w(sonots@gmail.com)
  gem.homepage = 'https://github.com/sonots/capistrano-colorized-stream'
  gem.summary = 'enables to watch logs on multiple deploying hosts in one view with a colored hostname at the head of each line'
  gem.description = gem.summary

  gem.rubyforge_project = "capistrano-colorized-stream"

  ignores = File.readlines('.gitignore').grep(/\S+/).map(&:chomp)
  dotfiles = %w(.gitignore)

  gem.files = Dir['**/*'].reject { |f| File.directory?(f) || ignores.any? { |i| File.fnmatch(i, f) } } + dotfiles
  gem.test_files = gem.files.grep(/^spec\//)
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency "colorize"
  gem.add_runtime_dependency "capistrano", "~> 2"

  # for testing
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.11"

  # for debug
  gem.add_development_dependency "pry"
  gem.add_development_dependency "pry-debugger"
  gem.add_development_dependency "tapp"
end
