require 'spec_helper'

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

    describe '#request!' do
      let :client do
        SMSBox.client 'url'
      end

      context 'when request succeeded' do
        it 'returns response' do
          response = WebsendResponse.new
          client.should_receive(:request).and_return(response)
          client.request!(WebsendRequest.new).should be response
        end
      end

      context 'when request failed' do
        it 'raises ResponseException' do
          response = WebsendResponse.new.tap do |res|
            res.error = 'My Error'
          end
          client.should_receive(:request).and_return(response)
          expect { client.request!(WebsendRequest.new) }.to raise_error(ResponseException, /My Error/)
        end
      end
    end
  end
end

