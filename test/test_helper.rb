require 'rubygems'

require 'test/unit'
require 'webmock/test_unit'
require 'shoulda'
require 'yaml'

require File.dirname(__FILE__) + '/../lib/realestate.rb'

credentials_path = File.join(ENV["HOME"], ".realestate-ruby")

if File.exists?(credentials_path)
  TEST_CREDENTIALS = YAML.load(File.open(credentials_path)).symbolize_keys
else
  puts "define YML credentials in ~/.realestate-ruby to run live tests"
  TEST_CREDENTIALS = { :public_key => 123, :private_key => 456}
end

def fixture_file(filename)
  File.read(File.join(File.dirname(__FILE__), "fixtures", filename))
end