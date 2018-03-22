require 'spec_helper'

describe Fountain::BookedSlot do
  let(:data) do
    {
      id: '21d7d019-7940-44d1-a710-0a79dd71cfcd',
      start_time: 'Wed, Jun 03 @11:27am PDT',
      end_time: 'Wed, Jun 03 @11:30am PDT',
      location: 'Seoul',
      recruiter: 'Owen',
      instructions: 'Please call us when you get here',
      showed_up: 'true'
    }
  end

  let(:slot) { Fountain::BookedSlot.new data }

  describe '#id' do
    it { expect(slot.id).to eq '21d7d019-7940-44d1-a710-0a79dd71cfcd' }
  end

  describe '#start_time' do
    it { expect(slot.start_time).to be_within(0.001).of Time.new(2018, 6, 3, 11, 27, 0, '-07:00') }
  end

  describe '#end_time' do
    it { expect(slot.end_time).to be_within(0.001).of Time.new(2018, 6, 3, 11, 30, 0, '-07:00') }
  end

  describe '#location' do
    it { expect(slot.location).to eq 'Seoul' }
  end

  describe '#recruiter' do
    it { expect(slot.recruiter).to eq 'Owen' }
  end

  describe '#instructions' do
    it { expect(slot.instructions).to eq 'Please call us when you get here' }
  end

  describe '#showed_up' do
    it { expect(slot.showed_up).to eq true }
  end
end
