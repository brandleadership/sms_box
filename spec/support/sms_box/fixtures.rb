module SMSBox
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
end
