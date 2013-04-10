require 'spec_helper'

WEBSEND_REQUEST = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLRequest>
  <username>myuser</username>
  <password>mypass</password>
  <command>WEBSEND</command>
  <parameters>
    <multiReceiver>+41790000001</multiReceiver>
    <multiReceiver>+41790000002</multiReceiver
    <multiReceiver>+41790000003</multiReceiver>
    <service>TEST</service>
    <text>This is a test message.</text>
  </parameters>
</SMSBoxXMLRequest>'

WEBSEND_RESPONSE = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLReply>
  <ok/>
  <command name="WEBSEND">
    <receiver status="ok">+41790000001</receiver>
    <receiver status="ok">+41790000002</receiver>
    <receiver status="ok">+41790000003</receiver>
  </command>
  <requestUid>xml9677322</requestUid>
</SMSBoxXMLReply>'

module SMSBox

  describe WebsendRequest do

    let :request do
      WebsendRequest.new.tap do |r|
        r.service = 'TEST'
        r.text = 'This is a test message.'
        r.receivers = [
          '+41790000001',
          '+41790000002',
          '+41790000003',
        ]
      end
    end

    let :client do
      ::SMSBox.client('http://smsgateway', {
        :username => 'myuser',
        :password => 'mypass'
      })
    end

    before :each do
      RestClient.should_receive(:post) do |url, xml, opts|
        actual_request = Nokogiri.XML(xml)
        expected_request = Nokogiri.XML(WEBSEND_REQUEST)
        actual_request.should be_equivalent_to(expected_request)
        url.should == 'http://smsgateway'
        opts.should == { :content_type => "text/xml" }
      end.and_return(WEBSEND_RESPONSE)
    end

    it 'simulates a end-to-end WEBSEND Request' do
      res = client.request(request)
      res
    end
  end
end
