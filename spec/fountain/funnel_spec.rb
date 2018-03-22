require 'spec_helper'

describe Fountain::Funnel do
  let(:data) do
    {
      'id' => '1f62e031-46b2-4cc6-92da-400182d2c88b',
      'title' => 'Future Factors Representative',
      'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc'
    }
  end
  let(:funnel) { Fountain::Funnel.new data }

  describe '#id' do
    it { expect(funnel.id).to eq '1f62e031-46b2-4cc6-92da-400182d2c88b' }
  end

  describe '#title' do
    it { expect(funnel.title).to eq 'Future Factors Representative' }
  end

  describe '#custom_id' do
    it { expect(funnel.custom_id).to eq '3d67750a-dcf4-4ada-a3e4-ee44661949fc' }
  end
end
