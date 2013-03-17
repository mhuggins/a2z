require 'spec_helper'

describe A2z::Requests::ResponseGroup do
  subject do
    A2z::Requests::ResponseGroup.new(value, &block)
  end
  
  let(:value) { nil }
  let(:block) { proc { } }
  
  describe '#params' do
    specify { subject.params.should be_a Hash }
    
    describe 'when value is a string' do
      let(:value) { 'OfferSummary' }
      
      it 'sets the response group' do
        subject.params['ResponseGroup'].should eq 'OfferSummary'
      end
    end
    
    describe 'when value is an array' do
      let(:value) { %w(OfferSummary Images) }
      
      it 'sets the comma-delimited response group' do
        subject.params['ResponseGroup'].should eq 'OfferSummary,Images'
      end
    end
    
    describe 'when the related item page is specified' do
      let(:block) { proc { related_item_page 2 } }
      
      it 'sets the related item page' do
        subject.params['RelatedItemPage'].should eq 2
      end
    end
    
    describe 'when the relationship type is specified' do
      let(:block) { proc { relationship_type 'Episode' } }
      
      it 'sets the relationship type' do
        subject.params['RelationshipType'].should eq 'Episode'
      end
    end
    
    describe 'when nothing is specified' do
      let(:block) { proc { } }
      
      it 'does not set the related item page' do
        subject.params.should_not have_key 'RelatedItemPage'
      end
      
      it 'does not set the relationship type' do
        subject.params.should_not have_key 'RelationshipType'
      end
    end
  end
end
