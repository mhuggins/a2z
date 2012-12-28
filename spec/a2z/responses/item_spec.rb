require 'spec_helper'

describe A2z::Responses::Item do
  subject do
    A2z::Responses::Item.from_response(item_hash)
  end
  
  let(:item_hash) { Hash.new }
  
  describe '.from_response' do
    it 'should return an item object'
  end
  
  describe '#asin' do
    it 'should return string'
  end
  
  describe '#detail_page_url' do
    it 'should return string'
  end
  
  describe '#links' do
    it 'should return array of item links'
  end
end
