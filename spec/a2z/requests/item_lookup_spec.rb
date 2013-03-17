require 'spec_helper'

describe A2z::Requests::ItemLookup do
  subject do
    A2z::Requests::ItemLookup.new(&block)
  end
  
  let(:block) { proc { } }
  
  describe '#params' do
    specify { subject.params.should be_a Hash }
    
    it 'sets the operation' do
      subject.params['Operation'].should eq 'ItemLookup'
    end
    
    describe 'when id is specified' do
      describe 'as a string' do
        let(:block) { proc { id 'ABC123' } }
        
        it 'sets the item ID' do
          subject.params['ItemId'].should eq 'ABC123'
        end
      end
      
      describe 'as an array' do
        let(:block) { proc { id %w(ABC123 DEF456) } }
        
        it 'sets the comma-delimited item ID' do
          subject.params['ItemId'].should eq 'ABC123,DEF456'
        end
      end
    end
    
    describe 'when category is specified' do
      let(:block) { proc { category 'Books' } }
      
      it 'sets the search index' do
        subject.params['SearchIndex'].should eq 'Books'
      end
    end
    
    describe 'when response group is specified' do
      let(:block) { proc { response_group 'Offers' } }
      
      it 'sets the response group' do
        subject.params['ResponseGroup'].should eq 'Offers'
      end
    end
    
    describe 'when include reviews summary is specified' do
      describe 'as true' do
        let(:block) { proc { include_reviews_summary true } }
        
        it 'sets include reviews summary' do
          subject.params['IncludeReviewsSummary'].should eq 'True'
        end
      end
      
      describe 'as false' do
        let(:block) { proc { include_reviews_summary false } }
        
        it 'sets include reviews summary' do
          subject.params['IncludeReviewsSummary'].should eq 'False'
        end
      end
    end
    
    describe 'when condition is specified' do
      let(:block) { proc { condition 'New' } }
      
      it 'sets condition' do
        subject.params['Condition'].should eq 'New'
      end
    end
    
    describe 'when ID type is specified' do
      let(:block) { proc { id_type 'ASIN' } }
      
      it 'sets ID type' do
        subject.params['IdType'].should eq 'ASIN'
      end
    end
    
    describe 'when merchant ID is specified' do
      let(:block) { proc { merchant_id 'ABC123' } }
      
      it 'sets merchant ID' do
        subject.params['MerchantId'].should eq 'ABC123'
      end
    end
    
    describe 'when truncate reviews at is specified' do
      let(:block) { proc { truncate_reviews_at 10 } }
      
      it 'sets truncate reviews at' do
        subject.params['TruncateReviewsAt'].should eq 10
      end
    end
    
    describe 'when variation page is specified' do
      let(:block) { proc { variation_page 10 } }
      
      it 'sets variation page' do
        subject.params['VariationPage'].should eq 10
      end
    end
    
    describe 'when nothing is specified' do
      let(:block) { proc { } }
      
      it 'does not set the item ID' do
        subject.params.should_not have_key 'ItemId'
      end
      
      it 'does not set the search index' do
        subject.params.should_not have_key 'SearchIndex'
      end
      
      it 'does not set the response group' do
        subject.params.should_not have_key 'ResponseGroup'
      end
      
      it 'does not set include reviews summary' do
        subject.params.should_not have_key 'IncludeReviewsSummary'
      end
      
      it 'does not set condition' do
        subject.params.should_not have_key 'Condition'
      end
      
      it 'does not set ID type' do
        subject.params.should_not have_key 'IdType'
      end
      
      it 'does not set merchant ID' do
        subject.params.should_not have_key 'MerchantId'
      end
      
      it 'does not set truncate reviews at' do
        subject.params.should_not have_key 'TruncateReviewsAt'
      end
      
      it 'does not set variation page' do
        subject.params.should_not have_key 'VariationPage'
      end
    end
  end
end
