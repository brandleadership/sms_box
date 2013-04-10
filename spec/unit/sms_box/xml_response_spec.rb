require 'spec_helper'

DUMMY_RESPONSE_OK = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLReply>
  <ok/>
  <command name="DUMMY"></command>
  <requestUid>xml9677322</requestUid>
</SMSBoxXMLReply>'

DUMMY_RESPONSE_ERROR = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLReply>
  <error type="ERROR_TYPE"/>
  <command name="DUMMY"></command>
  <requestUid>xml9677322</requestUid>
</SMSBoxXMLReply>'

module SMSBox
  class BrokenResponse; end
  class DummyResponse < XMLResponse; end

  describe XMLResponse do
    describe '#initialize' do
      it 'raises exception when initializing base class' do
        expect{ XMLResponse.new }.to raise_error(/XMLResponse needs to be subclassed/)
      end
    end

    describe '#from_xml' do
      it 'sets the requestUid' do
        XMLResponse.from_xml(DUMMY_RESPONSE_OK).requestUid.should == 'xml9677322'
      end

      context 'on success' do
        it 'success? returns true' do
          XMLResponse.from_xml(DUMMY_RESPONSE_OK).success?.should be_true
        end
      end

      context 'on error' do
        it 'error? returns true' do
          XMLResponse.from_xml(DUMMY_RESPONSE_ERROR).error?.should be_true
        end

        it 'error returns the error type' do
          XMLResponse.from_xml(DUMMY_RESPONSE_ERROR).error.should == 'ERROR_TYPE'
        end
      end
    end

    describe '#instantize' do
      context 'with invalid class name' do
        it 'raises exception' do
          expect{ XMLResponse.instantize(nil) }.to raise_error(
            NotImplementedError, /not implemented/
          )
          expect{ XMLResponse.instantize('') }.to raise_error(
            NotImplementedError, /not implemented/
          )
          expect{ XMLResponse.instantize('foo bar') }.to raise_error(
            NotImplementedError, /not implemented/
          )
        end
      end

      context 'when class is not subclass of XMLResponse' do
        it 'raises exception' do
          expect{ XMLResponse.instantize('BROKEN') }.to raise_error(
            /not a SMSBox::XMLResponse/
          )
        end
      end

      context 'with valid command' do
        it 'instantiates and returns response' do
          XMLResponse.instantize('DUMMY').should be_a(DummyResponse)
        end
      end
    end
  end
end
