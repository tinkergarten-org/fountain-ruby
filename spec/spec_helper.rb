require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'fountain'

RSpec.configure do |config|
  config.order = 'random'
end

require 'webmock/rspec'

AUTH_TOKEN = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'.freeze
UNAUTHORIZED_BODY = {
  message: 'Authentication is required'
}.to_json

### Authenticated request helpers

def stub_authed_request(method, action)
  stub_request(method, Fountain.host_path + action)
    .with(headers: { 'X-ACCESS-TOKEN' => AUTH_TOKEN })
end
