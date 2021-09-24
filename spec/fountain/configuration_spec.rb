# frozen_string_literal: true

require 'spec_helper'

describe Fountain do # rubocop:disable RSpec/FilePath
  it 'sets default value for host_path option' do
    expect(described_class.host_path).to eq 'https://api.fountain.com'
  end

  it 'does not have a default value for api_token option' do
    expect(described_class.api_token).to be_nil
  end

  describe '#configure' do
    before do
      described_class.configure do |config|
        config.host_path = 'https://example.com'
        config.api_token = 'qwerty123456'
      end
    end

    it 'applies configured host_path option' do
      expect(described_class.host_path).to eq 'https://example.com'
    end

    it 'applies configured api_token option' do
      expect(described_class.api_token).to eq 'qwerty123456'
    end
  end
end
