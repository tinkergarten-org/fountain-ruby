require 'spec_helper'

describe Fountain::Applicant do
  let(:data) do
    {
      'id' => '01234567-0000-0000-0000-000000000000',
      'email' => 'rich@gmail.com',
      'name' => 'Richard',
      'phone_number' => '79224568246',
      'data' => {
        'color_of_eyes' => 'brown'
      },
      'created_at' => '2015-06-05T05:53:38.974-07:00',
      'funnel' => {
        'id' => '1f62e031-46b2-4cc6-92da-400182d2c88b',
        'title' => 'Future Factors Representative',
        'custom_id' => '3d67750a-dcf4-4ada-a3e4-ee44661949fc'
      },
      'stage' => {
        'id' => '274d2929-e1d3-4535-b1b6-b5e4fc820f21',
        'title' => 'Approved'
      },
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

  let(:applicant) { Fountain::Applicant.new data }

  describe '#id' do
    it { expect(applicant.id).to eq '01234567-0000-0000-0000-000000000000' }
  end

  describe '#created_at' do
    it { expect(applicant.created_at).to be_within(0.001).of Time.new(2015, 6, 5, 5, 53, 38.974, '-07:00') }
  end

  describe '#email' do
    it { expect(applicant.email).to eq 'rich@gmail.com' }
  end

  describe '#name' do
    it { expect(applicant.name).to eq 'Richard' }
  end

  describe '#phone_number' do
    it { expect(applicant.phone_number).to eq '79224568246' }
  end

  describe '#data' do
    it { expect(applicant.data).to eq('color_of_eyes' => 'brown') }
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
