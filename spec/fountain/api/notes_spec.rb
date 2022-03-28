# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Api::Notes do
  before { Fountain.api_token = AUTH_TOKEN }

  after { Fountain.api_token = nil }

  let(:note) do
    {
      'id' => '8f247b3a-a473-4dfd-81cc-46fb527a8823',
      'content' => 'This is a great candidate',
      'created_at' => '2017-12-12T14:25:07.734-08:00',
      'updated_at' => '2017-12-13T14:25:07.734-08:00',
      'user' => user
    }
  end
  let(:note2) do
    {
      'id' => 'bc213c4a-3e58-4a0b-92f2-be980dd46ca9',
      'content' => 'This candidate was ok',
      'created_at' => '2017-12-15T14:25:07.123-08:00',
      'updated_at' => '2017-12-15T14:25:07.123-08:00',
      'user' => user
    }
  end
  let(:user) do
    {
      'name' => 'Ms. Tiana Hermiston',
      'email' => 'fixture-account-1513117507@owner.iq',
      'id' => 'b32b08ce-4a32-4de7-983a-7e2e521405a2'
    }
  end

  describe '.list' do
    before do
      # Stubs for /v2/applicants/:id/notes REST API
      stub_authed_request(:get, '/v2/applicants/01234567-0000-0000-0000-000000000000/notes')
        .to_return(
          body: { notes: [note] }.to_json,
          status: 200
        )
    end

    it 'returns the applicants notes' do
      notes = described_class.list(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(notes).to be_an Array
      expect(notes.map(&:class)).to eq [Fountain::Note]
      expect(notes.map(&:id)).to eq ['8f247b3a-a473-4dfd-81cc-46fb527a8823']
    end
  end

  describe '.create' do
    let(:user) { '' }

    before do
      # Stubs for /v2/applicants/:id/notes REST API
      stub_authed_request(:post, '/v2/applicants/01234567-0000-0000-0000-000000000000/notes')
        .with(
          body: { content: 'This is a great candidate' }.to_json
        )
        .to_return(
          body: note.to_json,
          status: 200
        )

      stub_authed_request(:post, '/v2/applicants/01234567-0000-0000-0000-000000000001/notes')
        .with(
          body: { content: 'This candidate was ok' }.to_json
        )
        .to_return(
          body: note2.to_json,
          status: 201
        )
    end

    it 'returns the created note' do
      note = described_class.create(
        '01234567-0000-0000-0000-000000000000',
        'This is a great candidate'
      )
      expect(note).to be_a Fountain::Note
      expect(note.id).to eq '8f247b3a-a473-4dfd-81cc-46fb527a8823'
    end

    it 'handles a 201 Created response' do
      note = described_class.create(
        '01234567-0000-0000-0000-000000000001',
        'This candidate was ok'
      )
      expect(note).to be_a Fountain::Note
      expect(note.id).to eq 'bc213c4a-3e58-4a0b-92f2-be980dd46ca9'
    end
  end

  describe '.delete' do
    before do
      # Stubs for /v2/applicants/:applicant_id/notes/:id REST API
      stub_authed_request(
        :delete,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/notes/11111111-0000-0000-0000-000000000000'
      ).to_return(status: 200)
    end

    it 'deletes the applicant' do
      result = described_class.delete(
        '01234567-0000-0000-0000-000000000000',
        '11111111-0000-0000-0000-000000000000'
      )
      expect(result).to be true
    end
  end

  describe '.update' do
    before do
      # Stubs for /v2/applicants/:applicant_id/notes/:id REST API
      stub_authed_request(
        :put,
        '/v2/applicants/01234567-0000-0000-0000-000000000000/notes/11111111-0000-0000-0000-000000000000'
      ).with(
        body: { content: 'This is a better candidate' }.to_json
      ).to_return(
        body: note.to_json,
        status: 200
      )
    end

    it 'returns the created note' do
      note = described_class.update(
        '01234567-0000-0000-0000-000000000000',
        '11111111-0000-0000-0000-000000000000',
        'This is a better candidate'
      )
      expect(note).to be_a Fountain::Note
      expect(note.id).to eq '8f247b3a-a473-4dfd-81cc-46fb527a8823'
    end
  end
end
