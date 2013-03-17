require 'spec_helper'

describe A2z::Requests::ItemSearch do
  subject do
    A2z::Requests::ItemSearch.new(&block)
  end
  
  let(:block) { Proc.new { } }
  
  describe '#params' do
    specify { subject.params.should be_a Hash }
  end
end
