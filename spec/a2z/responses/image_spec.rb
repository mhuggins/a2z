require 'spec_helper'

describe A2z::Responses::Image do
  subject do
    A2z::Responses::Image.from_response(image_hash)
  end
  
  let(:image_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an image object'
  end
end
