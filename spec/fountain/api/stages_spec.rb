# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Api::Stages do
  before { Fountain.api_token = AUTH_TOKEN }

  after { Fountain.api_token = nil }

  describe '.get' do
    let(:stage1) do
      {
        'id' => '70d446ca-670d-44be-a728-6c3d1921fb97',
        'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc',
        'title' => 'Approved',
        'type' => 'HiredStage',
        'position' => '4',
        'num_applicants' => 3
      }
    end

    before do
      # Stubs for /v2/funnels/:funnel_id REST API
      stub_authed_request(:get, "/v2/stages/#{stage1['id']}")
        .to_return(
          body: stage1.to_json,
          status: 200
        )
    end

    it 'returns the stage' do
      stage = described_class.get(stage1['id'])
      expect(stage).to be_a Fountain::Stage
      expect(stage.id).to eq stage1['id']
      expect(stage.title).to eq 'Approved'
    end
  end
end
