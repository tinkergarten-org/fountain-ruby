# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Api::Applicants do
  before { Fountain.api_token = AUTH_TOKEN }

  after { Fountain.api_token = nil }

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
  let(:applicant3) do
    {
      'id' => '01234567-0000-0000-0000-000000000002',
      'email' => 'tom@gmail.com',
      'name' => 'Tom'
    }
  end

  describe '.list' do
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
      applicants = described_class.list
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 2
      expect(applicants.map(&:name)).to eq %w[Richard Frank]

      expect(applicants.current_cursor).to eq 'cursor1'
      expect(applicants.next_cursor).to eq 'cursor2'
    end

    it 'passes through arguments' do
      applicants = described_class.list funnel_id: 1234, stage_id: 4567, stage: 'Foo'
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 1
      expect(applicants.map(&:name)).to eq ['Frank']

      expect(applicants.current_cursor).to eq 'cursor3'
      expect(applicants.next_cursor).to eq 'cursor4'
    end

    it 'filters out non-standard arguments' do
      applicants = described_class.list labels: 'Bar', cursor: 'abcd', foo: 'baz'
      expect(applicants).to be_an Fountain::Applicants

      expect(applicants.count).to eq 1
      expect(applicants.map(&:name)).to eq ['Richard']

      expect(applicants.current_cursor).to be_nil
      expect(applicants.next_cursor).to be_nil
    end
  end

  describe '.create' do
    before do
      # Stubs for /v2/applicants
      stub_authed_request(:post, '/v2/applicants')
        .with(
          body: {
            name: 'Richard',
            email: 'rich@gmail.com',
            phone_number: '1231231234'
          }.to_json
        )
        .to_return(
          body: applicant1.to_json,
          status: 200
        )

      stub_authed_request(:post, '/v2/applicants')
        .with(
          body: {
            name: 'Frank',
            email: 'frank@gmail.com',
            phone_number: '321321311',
            data: { foo: 'bar' },
            secure_data: { baz: 'foo' },
            funnel_id: 'funnel-id',
            stage_id: 'stage-id',
            skip_automated_actions: true
          }.to_json
        )
        .to_return(
          body: applicant2.to_json,
          status: 200
        )

      stub_authed_request(:post, '/v2/applicants')
        .with(
          body: {
            name: 'Tom',
            email: 'tom@gmail.com',
            phone_number: '0'
          }.to_json
        )
        .to_return(
          body: applicant3.to_json,
          status: 201
        )
    end

    it 'returns created applicant' do
      applicant = described_class.create(
        'Richard',
        'rich@gmail.com',
        '1231231234'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.id).to eq '01234567-0000-0000-0000-000000000000'
      expect(applicant.name).to eq 'Richard'
    end

    it 'filters out non-standard arguments' do
      applicant = described_class.create(
        'Frank',
        'frank@gmail.com',
        '321321311',
        data: { foo: 'bar' },
        secure_data: { baz: 'foo' },
        funnel_id: 'funnel-id',
        stage_id: 'stage-id',
        skip_automated_actions: true,
        invalid_arg: 'should not be included'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.id).to eq '01234567-0000-0000-0000-000000000001'
      expect(applicant.name).to eq 'Frank'
    end

    it 'handles a 201 Created response' do
      applicant = described_class.create(
        'Tom',
        'tom@gmail.com',
        '0'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.id).to eq '01234567-0000-0000-0000-000000000002'
      expect(applicant.name).to eq 'Tom'
    end
  end

  describe '.delete' do
    before do
      # Stubs for /v2/applicants/:id REST API
      stub_authed_request(:delete, '/v2/applicants/01234567-0000-0000-0000-000000000000')
        .to_return(status: 200)
    end

    it 'deletes the applicant' do
      result = described_class.delete('01234567-0000-0000-0000-000000000000')
      expect(result).to be true
    end
  end

  describe '.get' do
    before do
      # Stubs for /v2/applicants/:id REST API
      stub_authed_request(:get, '/v2/applicants/01234567-0000-0000-0000-000000000000')
        .to_return(
          body: applicant1.to_json,
          status: 200
        )
    end

    it 'returns the applicant' do
      applicant = described_class.get('01234567-0000-0000-0000-000000000000')
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.id).to eq '01234567-0000-0000-0000-000000000000'
      expect(applicant.name).to eq 'Richard'
    end
  end

  describe '.update' do
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
      # Stubs for /v2/applicants/:id PUT REST API
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
      applicant = described_class.update(
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
      applicant = described_class.update(
        '01234567-0000-0000-0000-000000000001',
        name: 'Franky',
        height: '150'
      )
      expect(applicant).to be_a Fountain::Applicant
      expect(applicant.name).to eq 'Franky'
    end

    it 'raises a not found error if ID was not found' do
      expect do
        described_class.update('1234', name: 'Franky')
      end.to raise_error Fountain::NotFoundError
    end
  end

  describe '.get_secure_documents' do
    let(:document1) do
      {
        'id' => 'a71d7cf4-2d9d-4d4b-82ef-8894bbe78120',
        'name' => 'upload_one',
        'friendly_name' => 'Upload one',
        'filename' => 'CCUzGocUMAEPkN3.jpg',
        'public_url' => 'https://filez.example.com/super/secret/file.pdf',
        'size' => 25_718,
        'stage' => {
          'id' => '1ac2f82c-caa9-4b13-ad5b-df555e050524',
          'title' => 'Approved'
        }
      }
    end

    before do
      # Stubs for /v2/applicants/:applicant_id/secure_documents REST API
      stub_authed_request(
        :get,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/secure_documents'
      ).to_return(
        body: { secure_documents: [document1] }.to_json,
        status: 200
      )
    end

    it 'returns the document' do
      documents = described_class.get_secure_documents('01234567-0000-0000-0000-000000000000')
      expect(documents).to be_an Array
      expect(documents.map(&:class)).to eq [Fountain::SecureDocument]
      expect(documents.map(&:id)).to eq ['a71d7cf4-2d9d-4d4b-82ef-8894bbe78120']
    end
  end

  describe '.advance_applicant' do
    before do
      # Stubs for /v2/applicants/:id/advance REST API
      stub_authed_request(:put, '/v2/applicants/01234567-0000-0000-0000-000000000000/advance')
        .to_return(status: 204)

      stub_authed_request(:put, '/v2/applicants/01234567-0000-0000-0000-000000000001/advance')
        .with(
          body: {
            skip_automated_actions: true,
            stage_id: 'stage-id'
          }.to_json
        )
        .to_return(status: 204)
    end

    it 'advances an applicant' do
      result = described_class.advance_applicant(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(result).to be true
    end

    it 'advances an applicant to a specific stage (ignoring non-standard arguments)' do
      result = described_class.advance_applicant(
        '01234567-0000-0000-0000-000000000001',
        skip_automated_actions: true,
        stage_id: 'stage-id',
        invalid_arg: 'should not be included'
      )
      expect(result).to be true
    end
  end

  describe '.get_interview_sessions' do
    let(:slot) do
      {
        'id' => '21d7d019-7940-44d1-a710-0a79dd71cfcd',
        'start_time' => 'Wed, Jun 03 @11:27am PDT',
        'end_time' => 'Wed, Jun 03 @11:30am PDT',
        'location' => 'Seoul',
        'recruiter' => 'Owen',
        'instructions' => 'Please call us when you get here',
        'showed_up' => 'true'
      }
    end

    before do
      # Stubs for /v2/applicants/:id/booked_slots REST API
      stub_authed_request(:get, '/v2/applicants/01234567-0000-0000-0000-000000000000/booked_slots')
        .to_return(
          body: { booked_slots: [slot] }.to_json,
          status: 200
        )
    end

    it 'returns the booked slots' do
      sessions = described_class.get_interview_sessions(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(sessions).to be_an Array
      expect(sessions.map(&:class)).to eq [Fountain::Slot]
      expect(sessions.map(&:id)).to eq ['21d7d019-7940-44d1-a710-0a79dd71cfcd']
    end
  end

  describe '.get_transition_history' do
    let(:transition) do
      {
        'stage_title' => 'Approved',
        'created_at' => '2016-12-12T13:24:44.381-08:00'
      }
    end

    before do
      # Stubs for /v2/applicants/:id/transitions REST API
      stub_authed_request(:get, '/v2/applicants/01234567-0000-0000-0000-000000000000/transitions')
        .to_return(
          body: { transitions: [transition] }.to_json,
          status: 200
        )
    end

    it 'returns the applicants transitions' do
      transitions = described_class.get_transition_history(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(transitions).to be_an Array
      expect(transitions.map(&:class)).to eq [Fountain::Transition]
      expect(transitions.map(&:stage_title)).to eq ['Approved']
    end
  end
end
