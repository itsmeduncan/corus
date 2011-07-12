require "bundler"
Bundler.setup

$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'tartarus'

RSpec.configure do |config|
  config.mock_with :mocha
end

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "#{root}/tmp/tartarus.db"
)
