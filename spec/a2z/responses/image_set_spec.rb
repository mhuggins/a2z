require 'spec_helper'

describe A2z::Responses::ImageSet do
  subject do
    A2z::Responses::ImageSet.from_response(image_set_hash)
  end
  
  let(:image_set_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an image set object'
  end
end
