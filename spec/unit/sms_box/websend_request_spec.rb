require 'spec_helper'

REQUEST = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLRequest>
  <username>USERNAME</username>
  <password>PASSWORD</password>
  <command>WEBSEND</command>
  <parameters>
    <multiReceiver>234234234</multiReceiver>
    <multiReceiver>123123123</multiReceiver>
    <service>SERVICE</service>
    <text>TEXT</text>
  </parameters>
</SMSBoxXMLRequest>'

module SMSBox

  describe WebsendRequest do
    describe '#initialize' do
      let :request do
        WebsendRequest.new.tap do |r|
          r.username = 'USERNAME'
          r.password = 'PASSWORD'
          r.service = 'SERVICE'
          r.text = 'TEXT'
          r.receivers = []
        end
      end

      it 'initializes the object' do
        request.username.should == 'USERNAME'
        request.password.should == 'PASSWORD'
        request.service.should == 'SERVICE'
        request.text.should == 'TEXT'
        request.receivers.should == []
      end
    end

    describe '#to_xml' do
      let :request do
        WebsendRequest.new.tap do |r|
          r.username = 'USERNAME'
          r.password = 'PASSWORD'
          r.service = 'SERVICE'
          r.text = 'TEXT'
          r.receivers = ['234234234', '123123123']
        end
      end

      it 'renders xml' do
        actual_request = Nokogiri.XML(request.to_xml)
        expected_request = Nokogiri.XML(REQUEST)
        actual_request.should be_equivalent_to(expected_request)
      end
    end
  end

end
