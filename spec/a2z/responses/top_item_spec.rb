require 'spec_helper'

describe A2z::Responses::TopItem do
  subject do
    A2z::Responses::TopItem.from_response(top_item_hash)
  end
  
  let(:top_item_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return a top item object'
  end
end
