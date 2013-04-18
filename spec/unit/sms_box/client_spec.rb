require 'spec_helper'

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
  class DummyResponse < XMLResponse; end

  describe Client do
    describe '#factory' do

      context 'when block given' do
        it 'can be configured with a block' do
          client = SMSBox.client 'url' do |c|
            c.username = 'username'
          end
          client.username.should == 'username'
        end
      end

      context 'when options given' do
        it 'can be configured with a hash' do
          client = SMSBox.client 'url', { username: 'username' }
          client.username.should == 'username'
        end
      end
    end

    describe '#request' do
      let :client do
        SMSBox.client 'url'
      end

      context 'with invalid parameter' do
        it 'raises exception' do
          expect{ client.request 'foo' }.to raise_error(/Invalid request/)
        end
      end

      context 'with valid request' do
        before :each do
          RestClient.should_receive(:post).with(
            'url',
            request.to_xml,
            :content_type => "text/xml"
          ).and_return('response')
          XMLResponse.should_receive(:from_xml).
            with('response').
            and_return(DummyResponse.new)
        end

        let :request do
          WebsendRequest.new
        end

        let :response do
          client.request(request)
        end

        it 'returns a XMLResponse object' do
          response.should be_a(XMLResponse)
        end

        it 'contains a reference to the request in response' do
          response.request.should be(request)
        end
      end
    end
  end
end

