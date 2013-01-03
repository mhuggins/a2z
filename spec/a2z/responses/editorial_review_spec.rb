require 'spec_helper'

describe A2z::Responses::EditorialReview do
  subject do
    A2z::Responses::EditorialReview.from_response(editorial_review_hash)
  end
  
  let(:editorial_review_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an editorial review object'
  end
end
