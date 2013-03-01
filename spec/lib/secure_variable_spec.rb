require 'spec_helper'

describe SystemConfiguration::SecureVariable do

  describe "#create" do 
 
    subject { SystemConfiguration::SecureVariable.create(:name => 'my_var', 
      	:value => '12345') }
    its(:value) { should = '12345' }
    
  end

  describe ".set_value" do

    subject { SystemConfiguration::SecureVariable.set_value('twitter.api_key', 
      '1234567890') }
    its(:value) { should == '1234567890' }

    context "max length" do
      variable_value=''
      256.times{variable_value<<'n'}
      subject { SystemConfiguration::SecureVariable.set_value('twitter.api_key', 
        variable_value) }
      its(:value) { should == variable_value }

    end

  end

  describe ".get_value" do

    before { SystemConfiguration::SecureVariable.set_value('fb.api_key', 
      '0987654321') }
    subject { SystemConfiguration::SecureVariable.get_value('fb.api_key') }
    it { should == '0987654321'}

  end

	
end