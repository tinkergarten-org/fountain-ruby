# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Slots do
  let(:data) do
    {
      slots: [
        {
          id: '21d7d019-7940-44d1-a710-0a79dd71cfcd',
          location: 'Stoltenbergburgh',
          start_time: 'Wed, Jun 03 @11:27am PDT',
          end_time: 'Wed, Jun 03 @11:27am PDT',
          recruiter: 'John Doe',
          max_attendees: 5,
          booked_slots_count: 3
        }
      ],
      pagination: pagination
    }
  end
  let(:pagination) do
    {
      first: 1,
      previous: '',
      current: 2,
      next: '',
      last: 3
    }
  end
  let(:slots) { Fountain::Slots.new data }

  describe '#current_page' do
    it { expect(slots.current_page).to eq 2 }
  end

  describe '#last_page' do
    it { expect(slots.last_page).to eq 3 }
  end

  context 'no pagination returned' do
    let(:pagination) { nil }

    describe '#current_page' do
      it { expect(slots.current_page).to be_nil }
    end

    describe '#last_page' do
      it { expect(slots.last_page).to be_nil }
    end
  end

  describe '#slots' do
    it { expect(slots.slots).to be_an Array }
    it { expect(slots.slots.map(&:class)).to eq [Fountain::Slot] }
    it { expect(slots.slots.map(&:location)).to eq ['Stoltenbergburgh'] }
  end

  describe '#each' do
    it { expect(slots).to delegate_method(:each).to :slots }
  end

  describe '#map' do
    it { expect(slots).to delegate_method(:map).to :slots }
  end

  describe '#count' do
    it { expect(slots).to delegate_method(:count).to :slots }
  end

  describe '#size' do
    it { expect(slots).to delegate_method(:size).to :slots }
  end

  describe '#[]' do
    it { expect(slots).to delegate_method(:[]).to :slots }
  end
end
