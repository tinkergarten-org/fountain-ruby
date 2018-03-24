require 'spec_helper'

describe Fountain::Slot do
  let(:data) do
    {
      id: '7f88228c-cba9-4827-b71d-e81244c05d37',
      name: 'San Francisco'
    }
  end

  let(:location) { Fountain::Location.new data }

  describe '#id' do
    it { expect(location.id).to eq '7f88228c-cba9-4827-b71d-e81244c05d37' }
  end

  describe '#name' do
    it { expect(location.name).to eq 'San Francisco' }
  end
end
