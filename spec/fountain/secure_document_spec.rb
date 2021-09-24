# frozen_string_literal: true

require 'spec_helper'

describe Fountain::SecureDocument do
  let(:data) do
    {
      id: 'a71d7cf4-2d9d-4d4b-82ef-8894bbe78120',
      name: 'upload_one',
      friendly_name: 'Upload one',
      filename: 'CCUzGocUMAEPkN3.jpg',
      public_url: 'https://filez.example.com/super/secret/file.pdf',
      size: 25_718,
      stage: {
        id: '1ac2f82c-caa9-4b13-ad5b-df555e050524',
        title: 'Approved'
      }
    }
  end

  let(:document) { described_class.new data }

  describe '#id' do
    it { expect(document.id).to eq 'a71d7cf4-2d9d-4d4b-82ef-8894bbe78120' }
  end

  describe '#name' do
    it { expect(document.name).to eq 'upload_one' }
  end

  describe '#friendly_name' do
    it { expect(document.friendly_name).to eq 'Upload one' }
  end

  describe '#filename' do
    it { expect(document.filename).to eq 'CCUzGocUMAEPkN3.jpg' }
  end

  describe '#public_url' do
    it { expect(document.public_url).to eq 'https://filez.example.com/super/secret/file.pdf' }
  end

  describe '#size' do
    it { expect(document.size).to eq 25_718 }
  end

  describe '#stage' do
    it { expect(document.stage).to be_a Fountain::Stage }
    it { expect(document.stage.id).to eq '1ac2f82c-caa9-4b13-ad5b-df555e050524' }
  end
end
