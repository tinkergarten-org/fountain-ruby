# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Api::AvailableSlots do
  before { Fountain.api_token = AUTH_TOKEN }

  after { Fountain.api_token = nil }

  let(:slot) do
    {
      'id' => 'ff4285bc-4988-4077-9ca8-ca95a765f99d',
      'location' => 'Liaside',
      'recruiter' => 'Aron DuBuque',
      'start_time' => 'Fri, Jun 05 @ 6:36am PDT',
      'end_time' => 'Fri, Jun 05 @ 6:36am PDT',
      'instructions' => 'Be careful!'
    }
  end

  describe '.confirm' do
    before do
      # Stubs for /v2/available_slots/:available_slot_id/confirm REST API
      stub_authed_request(
        :post,
        '/v2/available_slots/ff4285bc-4988-4077-9ca8-ca95a765f99d/confirm'
      ).with(
        body: {
          applicant_id: '01234567-0000-0000-0000-000000000000'
        }.to_json
      ).to_return(
        body: slot.to_json,
        status: 200
      )
    end

    it 'confirms the available slot' do
      slot = described_class.confirm(
        'ff4285bc-4988-4077-9ca8-ca95a765f99d',
        '01234567-0000-0000-0000-000000000000'
      )
      expect(slot).to be_a Fountain::Slot
      expect(slot.id).to eq 'ff4285bc-4988-4077-9ca8-ca95a765f99d'
    end
  end

  describe '.list' do
    let(:slot2) do
      {
        'id' => '21d7d019-7940-44d1-a710-0a79dd71cfcd',
        'location' => 'Stoltenbergburgh',
        'start_time' => 'Wed, Jun 03 @11:27am PDT',
        'end_time' => 'Wed, Jun 03 @11:27am PDT',
        'recruiter' => 'John Doe'
      }
    end

    before do
      # Stubs for /v2/stages/:stage_id/available_slots REST API
      stub_authed_request(
        :get,
        '/v2/stages/01234567-0000-0000-0000-000000000000/available_slots'
      ).to_return(
        body: {
          slots: [slot],
          pagination: {
            current: 1,
            last: 3
          }
        }.to_json,
        status: 200
      )

      stub_authed_request(
        :get,
        '/v2/stages/01234567-0000-0000-0000-000000000000/available_slots?page=3'
      ).to_return(
        body: { slots: [slot2] }.to_json,
        status: 200
      )
    end

    it 'returns first page of slots when only passed stage parameter' do
      slots = described_class.list(
        '01234567-0000-0000-0000-000000000000'
      )
      expect(slots).to be_an Fountain::Slots

      expect(slots.count).to eq 1
      expect(slots.map(&:id)).to eq ['ff4285bc-4988-4077-9ca8-ca95a765f99d']

      expect(slots.current_page).to eq 1
      expect(slots.last_page).to eq 3
    end

    it 'passes through page argument' do
      slots = described_class.list(
        '01234567-0000-0000-0000-000000000000',
        page: 3
      )
      expect(slots).to be_an Fountain::Slots

      expect(slots.count).to eq 1
      expect(slots.map(&:id)).to eq ['21d7d019-7940-44d1-a710-0a79dd71cfcd']

      expect(slots.current_page).to be_nil
      expect(slots.last_page).to be_nil
    end
  end

  describe '.cancel' do
    before do
      # Stubs for /v2/booked_slots/:booked_slot_id/cancel REST API
      stub_authed_request(
        :post,
        '/v2/booked_slots/22222222-0000-0000-0000-000000000000/cancel'
      ).to_return(status: 200)
    end

    it 'cancels a booked session' do
      result = described_class.cancel(
        '22222222-0000-0000-0000-000000000000'
      )
      expect(result).to be true
    end
  end
end
