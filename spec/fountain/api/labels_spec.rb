require 'spec_helper'

describe Fountain::Api::Labels do
  before { Fountain.api_token = AUTH_TOKEN }
  after { Fountain.api_token = nil }

  let(:label) do
    {
      'title' => 'Label 0',
      'completed' => true
    }
  end

  describe '.applicant_labels' do
    before do
      # Stubs for /v2/applicants/:id/labels REST API
      stub_authed_request(:get, '/v2/applicants/01234567-0000-0000-0000-000000000000/labels')
        .to_return(
          body: { labels: [label] }.to_json,
          status: 200
        )
    end

    it 'returns the applicants labels' do
      labels = Fountain::Api::Labels.applicant_labels(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(labels).to be_an Array
      expect(labels.map(&:class)).to eq [Fountain::Label]
      expect(labels.map(&:title)).to eq ['Label 0']
    end
  end

  describe '.update_applicant_label' do
    let(:label2) do
      {
        'title' => 'Other Label',
        'completed' => true
      }
    end

    let(:label3) do
      {
        'title' => 'New Label',
        'completed' => false
      }
    end

    before do
      # Stubs for /v2/applicants/:applicant_id/labels/:title REST API
      stub_authed_request(
        :put,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/labels/my_label'
      ).to_return(
         body: { labels: [label] }.to_json,
         status: 200
      )

      stub_authed_request(
        :put,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/labels/other-label'
      ).to_return(
        body: { labels: [label2] }.to_json,
        status: 200
      )

      stub_authed_request(
        :put,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/labels/New%20Label'
      ).with(
         body: {
           completed: false,
           completed_at: '2018-04-03'
         }.to_json
      ).to_return(
        body: { labels: [label3] }.to_json,
        status: 200
      )
    end

    it 'updates applicant labels' do
      labels = Fountain::Api::Labels.update_applicant_label(
        '01234567-0000-0000-0000-000000000000', 'my_label'
      )
      expect(labels).to be_an Array
      expect(labels.map(&:class)).to eq [Fountain::Label]
      expect(labels.map(&:title)).to eq ['Label 0']
    end

    it 'URI encodes labels' do
      labels = Fountain::Api::Labels.update_applicant_label(
        '01234567-0000-0000-0000-000000000000', 'other-label'
      )
      expect(labels).to be_an Array
      expect(labels.map(&:class)).to eq [Fountain::Label]
      expect(labels.map(&:title)).to eq ['Other Label']
    end

    it 'filters out non-standard arguments and formats completed_at date' do
      labels = Fountain::Api::Labels.update_applicant_label(
        '01234567-0000-0000-0000-000000000000', 'New Label',
        completed: false, completed_at: Date.new(2018, 4, 3)
      )
      expect(labels).to be_an Array
      expect(labels.map(&:class)).to eq [Fountain::Label]
      expect(labels.map(&:title)).to eq ['New Label']
    end
  end

  describe '.stage_labels' do
    before do
      # Stubs for /v2/stages/:stage_id/labels REST API
      stub_authed_request(:get, '/v2/stages/11111111-0000-0000-0000-000000000000/labels')
        .to_return(
          body: { labels: [label] }.to_json,
          status: 200
        )
    end

    it 'returns the stages labels' do
      labels = Fountain::Api::Labels.stage_labels(
        '11111111-0000-0000-0000-000000000000'
      )
      expect(labels).to be_an Array
      expect(labels.map(&:class)).to eq [Fountain::Label]
      expect(labels.map(&:title)).to eq ['Label 0']
    end
  end
end
