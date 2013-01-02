require 'spec_helper'

describe A2z::Responses::BrowseNode do
  subject do
    A2z::Responses::BrowseNode.from_response(browse_node_hash)
  end
  
  let(:browse_node_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return a browse node object'
  end
end
