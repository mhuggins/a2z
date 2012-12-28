require 'spec_helper'

describe A2z::Client do
  describe '#initialize' do
    subject do
      A2z::Client
    end
    
    context 'when country is not specified' do
      specify { expect { subject.new }.to_not raise_error }
    end
    
    context 'when country is valid' do
      specify { expect { subject.new(country: :us) }.to_not raise_error }
    end
    
    context 'when country is invalid' do
      specify { expect { subject.new(country: :fake) }.to raise_error }
    end
  end
  
  describe '#country=' do
    it 'should succeed'
  end
  
  describe '#country' do
    it 'should succeed'
  end
  
  describe '#tag' do
    it 'should succeed'
  end
  
  describe '#item_search' do
    subject do
      A2z::Client.new
    end
    
    it 'should succeed'
  end
  
  describe '#item_lookup' do
    subject do
      A2z::Client.new
    end
    
    it 'should succeed'
  end
end
