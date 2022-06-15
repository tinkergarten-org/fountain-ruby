# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Applicant do
  let(:data) do
    {
      'id' => '01234567-0000-0000-0000-000000000000',
      'email' => 'rich@gmail.com',
      'name' => 'Richard Irving',
      'first_name' => 'Richard',
      'last_name' => 'Irving',
      'phone_number' => '79224568246',
      'normalized_phone_number' => '+179224568246',
      'is_duplicate' => false,
      'receive_automated_emails' => true,
      'can_receive_sms' => true,
      'phone_platform' => 'sms',
      'rejection_reason' => 'not qualified enough',
      'on_hold_reason' => 'not a good fit',
      'data' => {
        'color_of_eyes' => 'brown'
      },
      'created_at' => '2015-06-05T05:53:38.974-07:00',
      'updated_at' => '2015-06-05T06:03:49.437-07:00',
      'last_transitioned_at' => '2015-06-07T12:34:10.321-07:00',
      'funnel' => {
        'id' => '1f62e031-46b2-4cc6-92da-400182d2c88b',
        'title' => 'Future Factors Representative',
        'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc'
      },
      'stage' => {
        'id' => '274d2929-e1d3-4535-b1b6-b5e4fc820f21',
        'title' => 'Approved'
      },
      'addresses' => [
        {
          'street_name' => '11718 Selkirk Drive',
          'address_2' => 'Apartment 101',
          'city' => 'Austin',
          'state' => 'Texas',
          'zipcode' => 78756, # rubocop:disable Style/NumericLiterals
          'country' => 'US',
          'latitude' => 60,
          'longitude' => 128
        }
      ],
      'background_checks' => [
        {
          'title' => 'Driver license check',
          'status' => 'pending',
          'vendor' => 'checkr',
          'candidate_id' => 'e44aa283528e6fde7d542194',
          'report_id' => '4722c07dd9a10c3985ae432a'
        }
      ],
      'document_signatures' => [
        {
          'vendor' => 'hellosign',
          'signature_id' => '123dfdsf',
          'status' => 'signed'
        }
      ],
      'labels' => [
        {
          'title' => 'Label-0',
          'completed' => true
        }
      ]
    }
  end

  let(:applicant) { described_class.new data }

  describe '#id' do
    it { expect(applicant.id).to eq '01234567-0000-0000-0000-000000000000' }
  end

  describe '#created_at' do
    it { expect(applicant.created_at).to be_within(0.001).of Time.new(2015, 6, 5, 5, 53, 38.974, '-07:00') }
  end

  describe '#updated_at' do
    it { expect(applicant.updated_at).to be_within(0.001).of Time.new(2015, 6, 5, 6, 3, 49.437, '-07:00') }
  end

  describe '#last_transitioned_at' do
    it { expect(applicant.last_transitioned_at).to be_within(0.001).of Time.new(2015, 6, 7, 12, 34, 10.321, '-07:00') }
  end

  describe '#email' do
    it { expect(applicant.email).to eq 'rich@gmail.com' }
  end

  describe '#name' do
    it { expect(applicant.name).to eq 'Richard Irving' }
  end

  describe '#first_name' do
    it { expect(applicant.first_name).to eq 'Richard' }
  end

  describe '#last_name' do
    it { expect(applicant.last_name).to eq 'Irving' }
  end

  describe '#phone_number' do
    it { expect(applicant.phone_number).to eq '79224568246' }
  end

  describe '#normalized_phone_number' do
    it { expect(applicant.normalized_phone_number).to eq '+179224568246' }
  end

  describe '#duplicate?' do
    it { expect(applicant.duplicate?).to be(false) }
  end

  describe '#receive_automated_emails?' do
    it { expect(applicant.receive_automated_emails?).to be(true) }
  end

  describe '#can_receive_sms?' do
    it { expect(applicant.can_receive_sms?).to be(true) }
  end

  describe '#phone_platform' do
    it { expect(applicant.phone_platform).to eq('sms') }
  end

  describe '#rejection_reason' do
    it { expect(applicant.rejection_reason).to eq('not qualified enough') }
  end

  describe '#on_hold_reason' do
    it { expect(applicant.on_hold_reason).to eq('not a good fit') }
  end

  describe '#data' do
    it { expect(applicant.data).to eq('color_of_eyes' => 'brown') }
  end

  describe '#addresses' do
    it do
      expect(applicant.addresses).to eq(
        [
          {
            'street_name' => '11718 Selkirk Drive',
            'address_2' => 'Apartment 101',
            'city' => 'Austin',
            'state' => 'Texas',
            'zipcode' => 78756, # rubocop:disable Style/NumericLiterals
            'country' => 'US',
            'latitude' => 60,
            'longitude' => 128
          }
        ]
      )
    end
  end

  describe '#funnel' do
    it { expect(applicant.funnel).to be_a Fountain::Funnel }
    it { expect(applicant.funnel.id).to eq '1f62e031-46b2-4cc6-92da-400182d2c88b' }
  end

  describe '#stage' do
    it { expect(applicant.stage).to be_a Fountain::Stage }
    it { expect(applicant.stage.id).to eq '274d2929-e1d3-4535-b1b6-b5e4fc820f21' }
  end

  describe '#background_checks' do
    it { expect(applicant.background_checks).to be_an Array }
    it { expect(applicant.background_checks.map(&:class)).to eq [Fountain::BackgroundCheck] }
    it { expect(applicant.background_checks.first.title).to eq 'Driver license check' }
  end

  describe '#document_signatures' do
    it { expect(applicant.document_signatures).to be_an Array }
    it { expect(applicant.document_signatures.map(&:class)).to eq [Fountain::DocumentSignature] }
    it { expect(applicant.document_signatures.first.signature_id).to eq '123dfdsf' }
  end
end
