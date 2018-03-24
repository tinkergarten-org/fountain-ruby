require 'spec_helper'

describe Fountain::Label do
  let(:data) do
    {
      'title' => 'Label 0',
      'completed' => true
    }
  end
  let(:label) { Fountain::Label.new data }

  describe '#title' do
    it { expect(label.title).to eq 'Label 0' }
  end

  describe '#completed' do
    it { expect(label.completed).to eq true }
  end
end
