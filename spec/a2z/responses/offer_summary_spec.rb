require 'spec_helper'

describe A2z::Responses::OfferSummary do
  subject do
    A2z::Responses::OfferSummary.from_response(offer_summary_hash)
  end
  
  let(:offer_summary_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an offer summary object'
  end
end
