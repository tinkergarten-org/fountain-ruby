require 'spec_helper'

describe Fountain::Stage do
  let(:data) do
    {
      'id' => '274d2929-e1d3-4535-b1b6-b5e4fc820f21',
      'title' => 'Approved'
    }
  end
  let(:stage) { Fountain::Stage.new data }

  describe '#id' do
    it { expect(stage.id).to eq '274d2929-e1d3-4535-b1b6-b5e4fc820f21' }
  end

  describe '#title' do
    it { expect(stage.title).to eq 'Approved' }
  end
end
