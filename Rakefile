require "bundler/gem_tasks"

require 'rake'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default  => :spec

desc "Start console mode w/ library loaded"
task :console do
  require 'pry'
  require_relative "lib/logification"
  ARGV.clear
  Pry.start
end