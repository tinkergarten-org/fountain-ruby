# frozen_string_literal: true

require 'spec_helper'

describe Fountain::User do
  let(:data) do
    {
      'name' => 'Ms. Tiana Hermiston',
      'email' => 'fixture-account-1513117507@owner.iq',
      'id' => 'b32b08ce-4a32-4de7-983a-7e2e521405a2'
    }
  end
  let(:user) { Fountain::User.new data }

  describe '#id' do
    it { expect(user.id).to eq 'b32b08ce-4a32-4de7-983a-7e2e521405a2' }
  end

  describe '#name' do
    it { expect(user.name).to eq 'Ms. Tiana Hermiston' }
  end

  describe '#email' do
    it { expect(user.email).to eq 'fixture-account-1513117507@owner.iq' }
  end
end
