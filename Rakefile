require "bundler/gem_tasks"

desc "Start console mode w/ library loaded"
task :console do
  require 'pry'
  require_relative "lib/logification"
  ARGV.clear
  Pry.start
end