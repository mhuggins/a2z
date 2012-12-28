require 'spec_helper'

describe A2z::Requests::ResponseGroup do
  subject do
    A2z::Requests::ResponseGroup.new(value, &block)
  end
  
  let(:value) { nil }
  let(:block) { Proc.new { } }
  
  describe '#params' do
    it 'should return a hash'
  end
end
