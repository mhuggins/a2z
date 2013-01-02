require 'spec_helper'

describe A2z::Responses::BrowseNodeLookup do
  subject do
    A2z::Responses::BrowseNodeLookup.from_response(browse_node_lookup_hash)
  end
  
  let(:browse_node_lookup_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return a browse node lookup object'
  end
end
