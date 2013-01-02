require 'spec_helper'

describe A2z::Requests::BrowseNodeLookup do
  subject do
    A2z::Requests::BrowseNodeLookup.new(id, &block)
  end
  
  let(:id) { 1 }
  let(:block) { Proc.new { } }
  
  describe '#params' do
    it 'should return a hash'
  end
end
