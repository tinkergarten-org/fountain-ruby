# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Transition do
  let(:data) do
    {
      'stage_title' => 'Approved',
      'created_at' => '2016-12-12T13:24:44.381-08:00'
    }
  end
  let(:transition) { Fountain::Transition.new data }

  describe '#stage_title' do
    it { expect(transition.stage_title).to eq 'Approved' }
  end

  describe '#created_at' do
    it do
      expect(transition.created_at).to(
        be_within(0.001).of(Time.new(2016, 12, 12, 13, 24, 44.381, '-08:00'))
      )
    end
  end
end
