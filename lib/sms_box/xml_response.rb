require 'nokogiri'
require 'active_support/inflector'

module SMSBox
  STATUS_OK = 'OK'
  STATUS_ERROR = 'ERROR'

  class XMLResponse

    attr_accessor :status
    attr_accessor :command
    attr_accessor :requestUid

    def initialize
      if self.instance_of? XMLResponse
        raise 'XMLResponse needs to be subclassed'
      end
    end

    def self.from_xml(xml_string)
      doc = Nokogiri::XML(xml_string)
      command = doc.xpath('//SMSBoxXMLReply/command').attr('name').value
      response = instantize(command)
    end

    def self.instantize(command)
      klass = nil
      begin
        class_name = "SMSBox::#{command.downcase.camelize}Response"
        klass = class_name.camelize.constantize
      rescue NameError => e
        raise NotImplementedError.new("'#{command}' not implemented")
      rescue Exception => e
        raise "'#{command}' could not be instantiated"
      end

      unless klass < XMLResponse
        raise "'#{command}' not a SMSBox::XMLResponse"
      end
      klass.new
    end

  end
end
