# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Applicants do
  let(:data) do
    {
      applicants: [
        {
          id: '01234567-0000-0000-0000-000000000000',
          email: 'rich@gmail.com',
          name: 'Richard'
        },
        {
          id: '01234567-0000-0000-0000-000000000001',
          email: 'frank@gmail.com',
          name: 'Frank'
        }
      ],
      pagination: pagination
    }
  end
  let(:pagination) do
    {
      current_cursor: 'cursor1',
      next_cursor: 'cursor2'
    }
  end
  let(:applicants) { Fountain::Applicants.new data }

  describe '#current_cursor' do
    it { expect(applicants.current_cursor).to eq 'cursor1' }
  end

  describe '#next_cursor' do
    it { expect(applicants.next_cursor).to eq 'cursor2' }
  end

  context 'no pagination returned' do
    let(:pagination) { nil }

    describe '#current_cursor' do
      it { expect(applicants.current_cursor).to be_nil }
    end

    describe '#next_cursor' do
      it { expect(applicants.next_cursor).to be_nil }
    end
  end

  describe '#applicants' do
    it { expect(applicants.applicants).to be_an Array }
    it { expect(applicants.applicants.map(&:class)).to eq [Fountain::Applicant, Fountain::Applicant] }
    it { expect(applicants.applicants.map(&:name)).to eq %w[Richard Frank] }
  end

  describe '#each' do
    it { expect(applicants).to delegate_method(:each).to :applicants }
  end

  describe '#map' do
    it { expect(applicants).to delegate_method(:map).to :applicants }
  end

  describe '#count' do
    it { expect(applicants).to delegate_method(:count).to :applicants }
  end

  describe '#size' do
    it { expect(applicants).to delegate_method(:size).to :applicants }
  end

  describe '#[]' do
    it { expect(applicants).to delegate_method(:[]).to :applicants }
  end
end
