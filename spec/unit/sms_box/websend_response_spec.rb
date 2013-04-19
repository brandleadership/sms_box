require 'spec_helper'

module SMSBox
  describe WebsendResponse do

    describe '#command_data=' do
      let :response do
        doc = Nokogiri::XML(WEBSEND_RESPONSE)
        WebsendResponse.new.tap do |res|
          res.command_data = doc.xpath('//SMSBoxXMLReply/command')
        end
      end

      it 'stores the receiver status hash' do
        response.receiver_status.should == [
          { :receiver => '+41790000001', :status => 'ok' },
          { :receiver => '+41790000002', :status => 'ok' },
          { :receiver => '+41790000003', :status => 'ok' }
        ]
      end
    end

  end
end
