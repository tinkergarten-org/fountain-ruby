# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Label do
  let(:data) do
    {
      'title' => 'Label 0',
      'completed' => true
    }
  end
  let(:label) { described_class.new data }

  describe '#title' do
    it { expect(label.title).to eq 'Label 0' }
  end

  describe '#completed' do
    it { expect(label.completed).to be true }
  end
end
