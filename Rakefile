# encoding: utf-8
require "bundler/gem_tasks"

desc 'Open an irb session preloaded with the gem library'
task :console do
    sh 'irb -rubygems -I lib -r capistrano-colorized-stream.rb'
end

task :c => :console
