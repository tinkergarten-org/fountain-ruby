# frozen_string_literal: true

require 'spec_helper'

describe Fountain::Stage do
  let(:data) do
    {
      'id' => '274d2929-e1d3-4535-b1b6-b5e4fc820f21',
      'title' => 'Approved',
      'type' => 'HiredStage'
    }
  end
  let(:stage) { described_class.new data }

  describe '#id' do
    it { expect(stage.id).to eq '274d2929-e1d3-4535-b1b6-b5e4fc820f21' }
  end

  describe '#title' do
    it { expect(stage.title).to eq 'Approved' }
  end

  describe '#type' do
    it { expect(stage.type).to eq 'HiredStage' }
  end
end
