$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app', 'controllers'))
require 'ops_routes'
require 'ops_routes/middleware'

# Define app controller since we're not in a rails app
class ApplicationController
  def self.unloadable
  end
end
require 'ops_controller'

require 'rubygems'
gem 'rack', '~>1.0'
require 'rack'
require 'spec'
# require 'spec/rails'
require 'spec/autorun'
require 'rack/test'
require 'rspec_tag_matchers'

Spec::Runner.configure do |config|
  include Rack::Test::Methods
  config.include(RspecTagMatchers)
end
