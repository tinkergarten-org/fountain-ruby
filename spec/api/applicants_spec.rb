require 'spec_helper'

describe Fountain::Api::Applicants do
  before { Fountain.api_token = AUTH_TOKEN }
  after { Fountain.api_token = nil }

  describe '#list' do
    let(:applicant1) do
      {
        'id' => '01234567-0000-0000-0000-000000000000',
        'email' => 'rich@gmail.com',
        'name' => 'Richard'
      }
    end
    let(:applicant2) do
      {
        'id' => '01234567-0000-0000-0000-000000000001',
        'email' => 'frank@gmail.com',
        'name' => 'Frank'
      }
    end

    before do
      # Stubs for /v2/applicants REST API
      stub_authed_request(:get, '/v2/applicants')
        .to_return(
          body: {
            applicants: [applicant1, applicant2],
            pagination: {
              current_cursor: 'cursor1',
              next_cursor: 'cursor2'
            }
          }.to_json,
          status: 200
        )

      stub_authed_request(:get, '/v2/applicants?funnel_id=1234&stage_id=4567&stage=Foo')
        .to_return(
          body: {
            applicants: [applicant2],
            pagination: {
              current_cursor: 'cursor3',
              next_cursor: 'cursor4'
            }
          }.to_json,
          status: 200
        )

      stub_authed_request(:get, '/v2/applicants?labels=Bar&cursor=abcd')
        .to_return(
          body: { applicants: [applicant1] }.to_json,
          status: 200
        )
    end

    it 'returns all applicants when passed no parameters' do
      applicants = Fountain::Api::Applicants.new.list
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 2
      expect(applicants.map(&:name)).to eq %w[Richard Frank]

      expect(applicants.current_cursor).to eq 'cursor1'
      expect(applicants.next_cursor).to eq 'cursor2'
    end

    it 'passes through arguments' do
      applicants = Fountain::Api::Applicants.new.list funnel_id: 1234, stage_id: 4567, stage: 'Foo'
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 1
      expect(applicants.map(&:name)).to eq ['Frank']

      expect(applicants.current_cursor).to eq 'cursor3'
      expect(applicants.next_cursor).to eq 'cursor4'
    end

    it 'filters out non-standard arguments' do
      applicants = Fountain::Api::Applicants.new.list labels: 'Bar', cursor: 'abcd', foo: 'baz'
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 1
      expect(applicants.map(&:name)).to eq ['Richard']

      expect(applicants.current_cursor).to be_nil
      expect(applicants.next_cursor).to be_nil
    end
  end

  describe '#update' do
    let(:applicant1) do
      {
        'id' => '01234567-0000-0000-0000-000000000000',
        'email' => 'richard@gmail.com',
        'name' => 'Dicky'
      }
    end
    let(:applicant2) do
      {
        'id' => '01234567-0000-0000-0000-000000000001',
        'email' => 'frank@gmail.com',
        'name' => 'Franky'
      }
    end

    before do
      # Stubs for /v2/applicants/:id REST API
      stub_authed_request(:put, '/v2/applicants/01234567-0000-0000-0000-000000000000')
        .with(
          body: {
            name: 'Dicky',
            email: 'richard@gmail.com',
            phone_number: '1234567890',
            data: { foo: 'bar' },
            secure_data: { baz: 'foo' },
            rejection_reason: 'You did not make the cut',
            on_hold_reason: 'Hold on please'
          }.to_json
        )
        .to_return(
          body: applicant1.to_json,
          status: 200
        )

      stub_authed_request(:put, '/v2/applicants/01234567-0000-0000-0000-000000000001')
        .with(body: { name: 'Franky' }.to_json)
        .to_return(
          body: applicant2.to_json,
          status: 200
        )

      stub_authed_request(:put, '/v2/applicants/1234')
        .with(body: { name: 'Franky' }.to_json)
        .to_return(
          body: { message: 'Requested resource not found' }.to_json,
          status: 404
        )
    end

    it 'returns updated applicant' do
      applicant = Fountain::Api::Applicants.new.update(
        '01234567-0000-0000-0000-000000000000',
        name: 'Dicky',
        email: 'richard@gmail.com',
        phone_number: '1234567890',
        data: { foo: 'bar' },
        secure_data: { baz: 'foo' },
        rejection_reason: 'You did not make the cut',
        on_hold_reason: 'Hold on please'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.name).to eq 'Dicky'
    end

    it 'filters out non-standard arguments' do
      applicant = Fountain::Api::Applicants.new.update(
        '01234567-0000-0000-0000-000000000001',
        name: 'Franky',
        height: '150'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.name).to eq 'Franky'
    end

    it 'raises a not found error if ID was not found' do
      expect do
        Fountain::Api::Applicants.new.update('1234', name: 'Franky')
      end.to raise_error Fountain::NotFoundError
    end
  end
end
