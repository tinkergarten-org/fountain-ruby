# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Funnels do
  let(:data) do
    {
      funnels: [
        {
          id: '49dbf2f3-057f-44b4-a638-8fac5aac2adf',
          custom_id: '3d67750a-dcf4-4ada-a3e4-ee44661949fc',
          title: 'My Public Funnel',
          address: '5th Ave. 13',
          time_zone: 'UTC',
          description: 'This funnel is for anyone',
          requirements: 'No need',
          fields: [
            {
              question: 'Foo',
              type: 'text_field',
              key: 'foo'
            }
          ],
          stages: [
            {
              id: '70d446ca-670d-44be-a728-6c3d1921fb97',
              title: 'Approved',
              type: 'HiredStage'
            }
          ],
          is_private: false,
          active: true,
          location: {
            id: '7f88228c-cba9-4827-b71d-e81244c05d37',
            name: 'San Francisco'
          }
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
  let(:funnels) { described_class.new data }

  describe '#current_page' do
    it { expect(funnels.current_page).to eq 2 }
  end

  describe '#last_page' do
    it { expect(funnels.last_page).to eq 3 }
  end

  context 'when no pagination returned' do
    let(:pagination) { nil }

    describe '#current_page' do
      it { expect(funnels.current_page).to be_nil }
    end

    describe '#last_page' do
      it { expect(funnels.last_page).to be_nil }
    end
  end

  describe '#funnels' do
    it { expect(funnels.funnels).to be_an Array }
    it { expect(funnels.funnels.map(&:class)).to eq [Fountain::Funnel] }
    it { expect(funnels.funnels.map(&:id)).to eq ['49dbf2f3-057f-44b4-a638-8fac5aac2adf'] }
  end

  describe '#each' do
    it { expect(funnels).to delegate_method(:each).to :funnels }
  end

  describe '#map' do
    it { expect(funnels).to delegate_method(:map).to :funnels }
  end

  describe '#count' do
    it { expect(funnels).to delegate_method(:count).to :funnels }
  end

  describe '#size' do
    it { expect(funnels).to delegate_method(:size).to :funnels }
  end

  describe '#[]' do
    it { expect(funnels).to delegate_method(:[]).to :funnels }
  end
end
