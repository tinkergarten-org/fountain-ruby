# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Note do
  let(:data) do
    {
      'id' => '8f247b3a-a473-4dfd-81cc-46fb527a8823',
      'content' => 'fff',
      'created_at' => '2017-12-12T14:25:07.734-08:00',
      'updated_at' => '2017-12-13T14:25:07.734-08:00',
      'user' => user_data
    }
  end
  let(:user_data) do
    {
      'name' => 'Ms. Tiana Hermiston',
      'email' => 'fixture-account-1513117507@owner.iq',
      'id' => 'b32b08ce-4a32-4de7-983a-7e2e521405a2'
    }
  end
  let(:note) { described_class.new data }

  describe '#id' do
    it { expect(note.id).to eq '8f247b3a-a473-4dfd-81cc-46fb527a8823' }
  end

  describe '#content' do
    it { expect(note.content).to eq 'fff' }
  end

  describe '#created_at' do
    it { expect(note.created_at).to be_within(0.001).of Time.new(2017, 12, 12, 14, 25, 7.734, '-08:00') }
  end

  describe '#updated_at' do
    it { expect(note.updated_at).to be_within(0.001).of Time.new(2017, 12, 13, 14, 25, 7.734, '-08:00') }
  end

  describe '#user' do
    it { expect(note.user).to be_a Fountain::User }
    it { expect(note.user.id).to eq 'b32b08ce-4a32-4de7-983a-7e2e521405a2' }

    context 'when user is blank' do
      let(:user_data) { '' }

      it { expect(note.user).to be_nil }
    end
  end
end
