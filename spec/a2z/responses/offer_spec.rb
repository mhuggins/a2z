require 'spec_helper'

describe A2z::Responses::Offer do
  subject do
    A2z::Responses::Offer.from_response(offer_hash)
  end
  
  let(:offer_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an offer object'
  end
end
