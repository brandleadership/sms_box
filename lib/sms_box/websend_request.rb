require 'nokogiri'

module SMSBox
  class WebsendRequest < XMLRequest
    attr_accessor :username
    attr_accessor :password
    attr_accessor :service
    attr_accessor :text
    attr_accessor :receivers
    attr_accessor :maximum_sms_amount

    def initialize
      self.receivers = []
    end

    def command
      'WEBSEND'
    end

    def decorate_xml(xml)
      xml.SMSBoxXMLRequest do |root|
        super(root)
        root.parameters do |parameters|
          receivers.each do |r|
            parameters.multiReceiver r
          end
          parameters.service service
          parameters.text_ text
          if maximum_sms_amount.present?
            parameters.maximumSMSAmount maximum_sms_amount
          end
        end
        xml
      end
    end
  end
end
