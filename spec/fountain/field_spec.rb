# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Field do
  let(:data) do
    {
      question: 'Foo',
      type: 'text_field',
      key: 'foo'
    }
  end

  let(:field) { described_class.new data }

  describe '#question' do
    it { expect(field.question).to eq 'Foo' }
  end

  describe '#type' do
    it { expect(field.type).to eq 'text_field' }
  end

  describe '#key' do
    it { expect(field.key).to eq 'foo' }
  end
end
