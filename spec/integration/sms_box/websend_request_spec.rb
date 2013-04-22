require 'spec_helper'

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
