require 'spec_helper'

describe A2z::Requests::ItemSearch do
  subject do
    A2z::Requests::ItemSearch.new(&block)
  end
  
  let(:block) { Proc.new { } }
  
  describe '#params' do
    specify { subject.params.should be_a Hash }
    
    it 'sets the operation' do
      subject.params['Operation'].should eq 'ItemSearch'
    end
    
    describe 'when keywords are specified' do
      describe 'as a string' do
        let(:block) { proc { keywords 'Harry Potter' } }
        
        it 'sets the keywords' do
          subject.params['Keywords'].should eq 'Harry Potter'
        end
      end
      
      describe 'as an array' do
        let(:block) { proc { keywords %w(Harry Potter) } }
        
        it 'sets the space-delimited keywords' do
          subject.params['Keywords'].should eq 'Harry Potter'
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
    
    describe 'when actor is specified' do
      let(:block) { proc { actor 'Matt Damon' } }
      
      it 'sets the actor' do
        subject.params['Actor'].should eq 'Matt Damon'
      end
    end
    
    describe 'when artist is specified' do
      let(:block) { proc { artist 'Grouplove' } }
      
      it 'sets the artist' do
        subject.params['Artist'].should eq 'Grouplove'
      end
    end
    
    describe 'when audience rating is specified' do
      let(:block) { proc { audience_rating 'PG' } }
      
      it 'sets the audience rating' do
        subject.params['AudienceRating'].should eq 'PG'
      end
    end
    
    describe 'when author is specified' do
      let(:block) { proc { author 'J.K. Rowling' } }
      
      it 'sets the author' do
        subject.params['Author'].should eq 'J.K. Rowling'
      end
    end
    
    describe 'when brand is specified' do
      let(:block) { proc { brand 'Timex' } }
      
      it 'sets the brand' do
        subject.params['Brand'].should eq 'Timex'
      end
    end
    
    describe 'when browse node is specified' do
      let(:block) { proc { browse_node 100 } }
      
      it 'sets the browse node' do
        subject.params['BrowseNode'].should eq 100
      end
    end
    
    describe 'when composer is specified' do
      let(:block) { proc { composer 'Bach' } }
      
      it 'sets the composer' do
        subject.params['Composer'].should eq 'Bach'
      end
    end
    
    describe 'when conductor is specified' do
      let(:block) { proc { conductor 'Gustav Mahler' } }
      
      it 'sets the conductor' do
        subject.params['Conductor'].should eq 'Gustav Mahler'
      end
    end
    
    describe 'when condition is specified' do
      let(:block) { proc { condition 'New' } }
      
      it 'sets the condition' do
        subject.params['Condition'].should eq 'New'
      end
    end
    
    describe 'when director is specified' do
      let(:block) { proc { director 'Judd Apatow' } }
      
      it 'sets the director' do
        subject.params['Director'].should eq 'Judd Apatow'
      end
    end
    
    describe 'when item page is specified' do
      let(:block) { proc { item_page 8 } }
      
      it 'sets the item page' do
        subject.params['ItemPage'].should eq 8
      end
    end
    
    describe 'when manufacturer is specified' do
      let(:block) { proc { manufacturer 'Dr Pepper' } }
      it 'sets the manufacturer' do
        subject.params['Manufacturer'].should eq 'Dr Pepper'
      end
    end
    
    describe 'when maximum price is specified' do
      let(:block) { proc { maximum_price 10.99 } }
      
      it 'sets the maximum price' do
        subject.params['MaximumPrice'].should eq 10.99
      end
    end
    
    describe 'when merchant ID is specified' do
      let(:block) { proc { merchant_id 'ABC123' } }
      
      it 'sets the merchant ID' do
        subject.params['MerchantId'].should eq 'ABC123'
      end
    end
    
    describe 'when minimum percentage off is specified' do
      let(:block) { proc { min_percentage_off 20 } }
      
      it 'sets the minimum percentage off' do
        subject.params['MinPercentageOff'].should eq 20
      end
    end
    
    describe 'when orchestra is specified' do
      let(:block) { proc { orchestra 'Antonio Vivaldi' } }
      
      it 'sets the orchestra' do
        subject.params['Orchestra'].should eq 'Antonio Vivaldi'
      end
    end
    
    describe 'when power search is specified' do
      let(:block) { proc { power 'subject:history and (spain or mexico) and not military and language:spanish' } }
      
      it 'sets the power' do
        subject.params['Power'].should eq 'subject:history and (spain or mexico) and not military and language:spanish'
      end
    end
    
    describe 'when publisher is specified' do
      let(:block) { proc { publisher 'EMI' } }
      
      it 'sets the publisher' do
        subject.params['Publisher'].should eq 'EMI'
      end
    end
    
    describe 'when sort is specified' do
      let(:block) { proc { sort 'inverse-pricerank' } }
      
      it 'sets the sort' do
        subject.params['Sort'].should eq 'inverse-pricerank'
      end
    end
    
    describe 'when title is specified' do
      let(:block) { proc { title 'The Wheel of Time' } }
      
      it 'sets the title' do
        subject.params['Title'].should eq 'The Wheel of Time'
      end
    end
    
    describe 'when variation page is specified' do
      let(:block) { proc { variation_page 2 } }
      
      it 'sets the variation page' do
        subject.params['VariationPage'].should eq 2
      end
    end
    
    describe 'when truncate reviews at is specified' do
      let(:block) { proc { truncate_reviews_at 5 } }
      
      it 'sets the truncate reviews at' do
        subject.params['TruncateReviewsAt'].should eq 5
      end
    end
    
    describe 'when nothing is specified' do
      let(:block) { proc { } }
      
      it 'does not set the keywords' do
        subject.params.should_not have_key 'Keywords'
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
      
      it 'does not set actor' do
        subject.params.should_not have_key 'Actor'
      end
      
      it 'does not set artist' do
        subject.params.should_not have_key 'Artist'
      end
      
      it 'does not set audience rating' do
        subject.params.should_not have_key 'AudienceRating'
      end
      
      it 'does not set author' do
        subject.params.should_not have_key 'Author'
      end
      
      it 'does not set brand' do
        subject.params.should_not have_key 'Brand'
      end
      
      it 'does not set browse node' do
        subject.params.should_not have_key 'BrowseNode'
      end
      
      it 'does not set composer' do
        subject.params.should_not have_key 'Composer'
      end
      
      it 'does not set conductor' do
        subject.params.should_not have_key 'Conductor'
      end
      
      it 'does not set condition' do
        subject.params.should_not have_key 'Condition'
      end
      
      it 'does not set director' do
        subject.params.should_not have_key 'Director'
      end
      
      it 'does not set item page' do
        subject.params.should_not have_key 'ItemPage'
      end
      
      it 'does not set manufacturer' do
        subject.params.should_not have_key 'Manufacturer'
      end
      
      it 'does not set maximum price' do
        subject.params.should_not have_key 'MaximumPrice'
      end
      
      it 'does not set merchant ID' do
        subject.params.should_not have_key 'MerchantId'
      end
      
      it 'does not set minimum price' do
        subject.params.should_not have_key 'MinimumPrice'
      end
      
      it 'does not set minimum percentage off' do
        subject.params.should_not have_key 'MinPercentageOff'
      end
      
      it 'does not set music label' do
        subject.params.should_not have_key 'MusicLabel'
      end
      
      it 'does not set orchestra' do
        subject.params.should_not have_key 'Orchestra'
      end
      
      it 'does not set power' do
        subject.params.should_not have_key 'Power'
      end
      
      it 'does not set publisher' do
        subject.params.should_not have_key 'Publisher'
      end
      
      it 'does not set sort' do
        subject.params.should_not have_key 'Sort'
      end
      
      it 'does not set title' do
        subject.params.should_not have_key 'Title'
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
