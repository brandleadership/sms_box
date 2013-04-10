require 'spec_helper'

DUMMY_RESPONSE = '<?xml version="1.0" encoding="UTF-8" ?>
<SMSBoxXMLReply>
  <ok/>
  <command name="DUMMY">
    <receiver status="ok">+41790000001</receiver>
    <receiver status="ok">+41790000002</receiver>
    <receiver status="ok">+41790000003</receiver>
  </command>
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

    #describe '#from_xml' do
      #XMLResponse.from_xml(DUMMY_RESPONSE)
    #end

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
    end
  end
end
