require 'spec_helper'

describe A2z do
  subject { A2z }
  
  specify { subject::VERSION.should == '0.0.3' }
end
