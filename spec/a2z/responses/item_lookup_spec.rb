require 'spec_helper'

describe A2z::Responses::ItemLookup do
  subject do
    A2z::Responses::ItemLookup.from_response(item_hash)
  end
  
  let(:item_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an item lookup object'
  end
end
