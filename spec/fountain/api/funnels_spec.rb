# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Api::Funnels do
  before { Fountain.api_token = AUTH_TOKEN }

  after { Fountain.api_token = nil }

  let(:funnel1) do
    {
      'id' => '49dbf2f3-057f-44b4-a638-8fac5aac2adf',
      'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc',
      'title' => 'My Public Funnel',
      'address' => '5th Ave. 13',
      'time_zone' => 'UTC',
      'description' => 'This funnel is for anyone',
      'requirements' => 'No need',
      'fields' => [
        {
          'question' => 'Foo',
          'type' => 'text_field',
          'key' => 'foo'
        }
      ],
      'stages' => [
        {
          'id' => '70d446ca-670d-44be-a728-6c3d1921fb97',
          'title' => 'Approved',
          'type' => 'HiredStage'
        }
      ],
      'is_private' => false,
      'active' => true,
      'location' => {
        'id' => '7f88228c-cba9-4827-b71d-e81244c05d37',
        'name' => 'San Francisco'
      }
    }
  end

  describe '.list' do
    before do
      # Stubs for /v2/funnels REST API
      stub_authed_request(:get, '/v2/funnels')
        .to_return(
          body: {
            funnels: [funnel1],
            pagination: {
              current: 1,
              last: 3
            }
          }.to_json,
          status: 200
        )

      stub_authed_request(:get, '/v2/funnels?page=3')
        .to_return(
          body: { funnels: [funnel1] }.to_json,
          status: 200
        )
    end

    it 'returns first page of funnels when no parameters passed' do
      funnels = described_class.list
      expect(funnels).to be_a Fountain::Funnels

      expect(funnels.count).to eq 1
      expect(funnels.map(&:id)).to eq ['49dbf2f3-057f-44b4-a638-8fac5aac2adf']

      expect(funnels.current_page).to eq 1
      expect(funnels.last_page).to eq 3
    end

    it 'passes through page argument' do
      funnels = described_class.list(page: 3)
      expect(funnels).to be_an Fountain::Funnels

      expect(funnels.count).to eq 1
      expect(funnels.map(&:id)).to eq ['49dbf2f3-057f-44b4-a638-8fac5aac2adf']

      expect(funnels.current_page).to be_nil
      expect(funnels.last_page).to be_nil
    end
  end

  describe '.get' do
    let(:funnel_id) { '49dbf2f3-057f-44b4-a638-8fac5aac2adf' }

    before do
      # Stubs for /v2/funnels/:funnel_id REST API
      stub_authed_request(:get, "/v2/funnels/#{funnel_id}")
        .to_return(
          body: funnel1.to_json,
          status: 200
        )
    end

    it 'returns the funnel' do
      funnel = described_class.get(funnel_id)
      expect(funnel).to be_a Fountain::Funnel
      expect(funnel.id).to eq funnel_id
      expect(funnel.title).to eq 'My Public Funnel'
    end
  end

  describe '.update' do
    before do
      # Stubs for /v2/funnels/:id REST API
      stub_authed_request(:put, '/v2/funnels/550e8400-e29b-41d4-a716-446655440000')
        .to_return(
          body: funnel1.to_json,
          status: 200
        )

      stub_authed_request(:put, '/v2/funnels/550e8400-e29b-41d4-a716-446655440000')
        .with(body: { custom_id: '3d67750a-dcf4-4ada-a3e4-ee44661949fc' })
        .to_return(
          body: funnel1.to_json,
          status: 200
        )
    end

    it 'updates funnel' do
      funnel = described_class.update(
        '550e8400-e29b-41d4-a716-446655440000'
      )
      expect(funnel).to be_a Fountain::Funnel
      expect(funnel.id).to eq '49dbf2f3-057f-44b4-a638-8fac5aac2adf'
    end

    it 'filters non-standard arguments' do
      funnel = described_class.update(
        '550e8400-e29b-41d4-a716-446655440000',
        custom_id: '3d67750a-dcf4-4ada-a3e4-ee44661949fc'
      )
      expect(funnel).to be_a Fountain::Funnel
      expect(funnel.id).to eq '49dbf2f3-057f-44b4-a638-8fac5aac2adf'
    end
  end

  describe '.list_stages' do
    let(:stage) do
      {
        'id' => '70d446ca-670d-44be-a728-6c3d1921fb97',
        'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc',
        'title' => 'Approved',
        'type' => 'HiredStage'
      }
    end

    before do
      # Stubs for /v2/funnels/:funnel_id/stages REST API
      stub_authed_request(
        :get,
        '/v2/funnels/550e8400-e29b-41d4-a716-446655440000/stages'
      ).to_return(
        body: { stages: [stage] }.to_json,
        status: 200
      )
    end

    it 'returns all stages for a funnel' do
      stages = described_class.list_stages(
        '550e8400-e29b-41d4-a716-446655440000'
      )
      expect(stages).to be_an Array
      expect(stages.map(&:class)).to eq [Fountain::Stage]
      expect(stages.map(&:id)).to eq ['70d446ca-670d-44be-a728-6c3d1921fb97']
    end
  end
end
