# frozen_string_literal: true

require 'spec_helper'

describe Fountain::DocumentSignature do
  let(:data) do
    {
      'vendor' => 'hellosign',
      'signature_id' => '123dfdsf',
      'status' => 'signed'
    }
  end
  let(:document_signature) { Fountain::DocumentSignature.new data }

  describe '#signature_id' do
    it { expect(document_signature.signature_id).to eq '123dfdsf' }
  end

  describe '#vendor' do
    it { expect(document_signature.vendor).to eq 'hellosign' }
  end

  describe '#status' do
    it { expect(document_signature.status).to eq 'signed' }
  end
end
