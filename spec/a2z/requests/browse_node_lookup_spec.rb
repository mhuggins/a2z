require 'spec_helper'

describe A2z::Requests::BrowseNodeLookup do
  subject do
    A2z::Requests::BrowseNodeLookup.new(id, &block)
  end
  
  let(:id) { 1 }
  let(:block) { proc { } }
  
  describe '#params' do
    specify { subject.params.should be_a Hash }
    
    it 'sets the operation' do
      subject.params['Operation'].should eq 'BrowseNodeLookup'
    end
    
    it 'sets the passed node ID' do
      subject.params['BrowseNodeId'].should eq id
    end
    
    describe 'when response group is specified' do
      let(:block) { proc { response_group 'Offers' } }
      
      it 'sets the response group' do
        subject.params['ResponseGroup'].should eq 'Offers'
      end
    end
    
    describe 'when nothing is specified' do
      let(:block) { proc { } }
      
      it 'does not set response group' do
        subject.params.should_not have_key 'ResponseGroup'
      end
    end
  end
end
