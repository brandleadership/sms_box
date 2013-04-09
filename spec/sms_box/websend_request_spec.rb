require 'spec_helper'

module SMSBox

  describe WebsendRequest do
    describe '#initialize' do
      let :request do
        WebsendRequest.new.tap do |r|
          r.username = 'USERNAME'
          r.password = 'PASSWORD'
          r.service = 'SERVICE'
          r.text = 'TEXT'
          r.cost = 50
        end
      end

      it 'initializes the object' do
        request.username.should == 'USERNAME'
        request.password.should == 'PASSWORD'
        request.service.should == 'SERVICE'
        request.text.should == 'TEXT'
        request.cost.should == 50
      end
    end
  end

end
