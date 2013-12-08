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
  
  describe '#country' do
    subject do
      A2z::Client.new(country: :us)
    end
    
    specify { subject.country.should eq :us }
  end
  
  describe '#country=' do
    subject do
      A2z::Client.new
    end
    
    before do
      subject.country.should_not eq :fr
      subject.country = :fr
    end
    
    specify { subject.country.should eq :fr }
  end
  
  describe '#tag' do
    subject do
      A2z::Client.new(tag: 'MyTag')
    end
    
    specify { subject.tag.should eq 'MyTag' }
  end
  
  describe '#item_search' do
    subject do
      A2z::Client.new(key: 'MyKey', secret: 'MySecret', tag: 'MyTag')
    end
    
    before do
      subject.stub(:get).and_return(item_search_response)
    end
    
    let(:block) { proc {} }
    
    it 'forwards through item search request' do
      A2z::Requests::ItemSearch.should_receive(:new).with(&block).and_call_original
      subject.item_search(&block)
    end
    
    it 'parses item search response' do
      A2z::Responses::ItemSearch.should_receive(:from_response)
      subject.item_search(&block)
    end
  end
  
  describe '#item_lookup' do
    subject do
      A2z::Client.new(key: 'MyKey', secret: 'MySecret', tag: 'MyTag')
    end
    
    before do
      subject.stub(:get).and_return(item_lookup_response)
    end
    
    let(:block) { proc {} }
    
    it 'forwards through item search request' do
      A2z::Requests::ItemLookup.should_receive(:new).with(&block).and_call_original
      subject.item_lookup(&block)
    end
    
    it 'parses item search response' do
      A2z::Responses::ItemLookup.should_receive(:from_response)
      subject.item_lookup(&block)
    end
  end
  
  describe '#browse_node_lookup' do
    subject do
      A2z::Client.new(key: 'MyKey', secret: 'MySecret', tag: 'MyTag')
    end
    
    before do
      subject.stub(:get).and_return(browse_node_lookup_response)
    end
    
    let(:id) { 1 }
    let(:block) { proc {} }
    
    it 'forwards through item search request' do
      A2z::Requests::BrowseNodeLookup.should_receive(:new).with(id, &block).and_call_original
      subject.browse_node_lookup(id, &block)
    end
    
    it 'parses item search response' do
      A2z::Responses::BrowseNodeLookup.should_receive(:from_response)
      subject.browse_node_lookup(id, &block)
    end
  end
  
  private
  
  def item_search_response
    double(body: '<OperationRequest/><Items/>')
  end
  
  def item_lookup_response
    double(body: '<OperationRequest/><Items/>')
  end
  
  def browse_node_lookup_response
    double(body: '<OperationRequest/><BrowseNodes><BrowseNode/></BrowseNodes>')
  end
end
