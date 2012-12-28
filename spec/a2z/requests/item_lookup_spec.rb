require 'spec_helper'

describe A2z::Requests::ItemLookup do
  subject do
    A2z::Requests::ItemLookup.new(&block)
  end
  
  let(:block) { Proc.new { } }
  
  describe '#params' do
    it 'should return a hash'
  end
end
