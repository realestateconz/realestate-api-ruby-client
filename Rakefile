require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => "test:units"

# FIXME: I'm sure this can be DRY'd up.
namespace :test do
  desc 'Runs unit tests for the Realestate Ruby Client'
  Rake::TestTask.new(:units) do |t|
    t.libs << '.'
    t.pattern = 'test/unit/*_test.rb'
    t.verbose = true
  end

  desc 'Runs live integration tests for the Realestate Ruby Client'
  Rake::TestTask.new(:remote) do |t|
    t.libs << '.'
    t.pattern = 'test/remote/*_test.rb'
    t.verbose = true
  end
end