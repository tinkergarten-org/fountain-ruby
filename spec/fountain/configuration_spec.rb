# frozen_string_literal: true

require 'spec_helper'

describe Fountain do
  it 'should set default value for host_path option' do
    expect(Fountain.host_path).to eq 'https://api.fountain.com'
  end

  it 'should not have a default value for api_token option' do
    expect(Fountain.api_token).to be_nil
  end

  describe '#configure' do
    before do
      Fountain.configure do |config|
        config.host_path = 'https://example.com'
        config.api_token = 'qwerty123456'
      end
    end

    it 'should apply configured host_path option' do
      expect(Fountain.host_path).to eq 'https://example.com'
    end

    it 'should apply configured api_token option' do
      expect(Fountain.api_token).to eq 'qwerty123456'
    end
  end
end
