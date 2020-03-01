# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'fountain'
require 'support/delegate_method_matcher'

RSpec.configure do |config|
  config.order = 'random'
end

require 'webmock/rspec'

AUTH_TOKEN = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
UNAUTHORIZED_BODY = {
  message: 'Authentication is required'
}.to_json

### Authenticated request helpers

def stub_authed_request(method, action)
  stub_request(method, Fountain.host_path + action)
    .with(headers: { 'X-ACCESS-TOKEN' => AUTH_TOKEN })
end
