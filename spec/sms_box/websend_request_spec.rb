require 'spec_helper'

REQUEST = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLRequest>
  <username>myuser</username>
  <password>mypass</password>
  <command>WEBSEND</command>
  <parameters>
    <multiReceiver>+41790000001</multiReceiver>
    <multiReceiver>+41790000002</multiReceiver>
    <multiReceiver>+41790000003</multiReceiver>
    <service>TEST</service>
    <text>This is a test message.</text>
    <guessOperator/>
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
        request.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<SMSBoxXMLRequest>\n  <username>USERNAME</username>\n  <password>PASSWORD</password>\n  <command>WEBSEND</command>\n  <parameters><multiReceiver>234234234</multiReceiver><multiReceiver>123123123</multiReceiver><service>SERVICE</service>TEXT</parameters>\n</SMSBoxXMLRequest>\n"
      end
    end
  end

end
