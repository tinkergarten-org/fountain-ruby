require 'spec_helper'

describe Fountain::Funnel do
  let(:data) do
    {
      'id' => '1f62e031-46b2-4cc6-92da-400182d2c88b',
      'title' => 'Future Factors Representative',
      'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc',
      'address' => '5th Ave. 13',
      'time_zone' => 'UTC',
      'description' => 'This funnel is for anyone',
      'requirements' => 'No need',
      'fields' => fields,
      'stages' => stages,
      'is_private' => false,
      'active' => true,
      'location' => location
    }
  end
  let(:fields) do
    [
      {
        'question' => 'Foo',
        'type' => 'text_field',
        'key' => 'foo'
      }
    ]
  end
  let(:stages) do
    [
      {
        'id' => '70d446ca-670d-44be-a728-6c3d1921fb97',
        'title' => 'Approved',
        'type' => 'HiredStage'
      }
    ]
  end
  let(:location) do
    {
      'id' => '7f88228c-cba9-4827-b71d-e81244c05d37',
      'name' => 'San Francisco'
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

  describe '#address' do
    it { expect(funnel.address).to eq '5th Ave. 13' }
  end

  describe '#time_zone' do
    it { expect(funnel.time_zone).to eq 'UTC' }
  end

  describe '#description' do
    it { expect(funnel.description).to eq 'This funnel is for anyone' }
  end

  describe '#requirements' do
    it { expect(funnel.requirements).to eq 'No need' }
  end

  describe '#fields' do
    it { expect(funnel.fields).to be_an Array }
    it { expect(funnel.fields.map(&:class)).to eq [Fountain::Field] }
    it { expect(funnel.fields.map(&:question)).to eq ['Foo'] }

    context 'no fields provided' do
      let(:fields) { nil }
      it { expect(funnel.fields).to eq [] }
    end
  end

  describe '#stages' do
    it { expect(funnel.stages).to be_an Array }
    it { expect(funnel.stages.map(&:class)).to eq [Fountain::Stage] }
    it { expect(funnel.stages.map(&:id)).to eq ['70d446ca-670d-44be-a728-6c3d1921fb97'] }

    context 'no stages provided' do
      let(:stages) { nil }
      it { expect(funnel.stages).to eq [] }
    end
  end

  describe '#is_private?' do
    it { expect(funnel).not_to be_private }
  end

  describe '#active?' do
    it { expect(funnel).to be_active }
  end

  describe '#location' do
    it { expect(funnel.location).to be_an Fountain::Location }
    it { expect(funnel.location.id).to eq '7f88228c-cba9-4827-b71d-e81244c05d37' }

    context 'no location provided' do
      let(:location) { nil }
      it { expect(funnel.location).to be_nil }
    end
  end
end
