# frozen_string_literal: true

require 'spec_helper'

describe Fountain::BackgroundCheck do
  let(:data) do
    {
      'title' => 'Driver license check',
      'status' => 'pending',
      'vendor' => 'checkr',
      'candidate_id' => 'e44aa283528e6fde7d542194',
      'report_id' => '4722c07dd9a10c3985ae432a'
    }
  end
  let(:background_check) { described_class.new data }

  describe '#title' do
    it { expect(background_check.title).to eq 'Driver license check' }
  end

  describe '#status' do
    it { expect(background_check.status).to eq 'pending' }
  end

  describe '#vendor' do
    it { expect(background_check.vendor).to eq 'checkr' }
  end

  describe '#candidate_id' do
    it { expect(background_check.candidate_id).to eq 'e44aa283528e6fde7d542194' }
  end

  describe '#report_id' do
    it { expect(background_check.report_id).to eq '4722c07dd9a10c3985ae432a' }
  end
end
