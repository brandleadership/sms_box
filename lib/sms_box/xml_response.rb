require 'nokogiri'
require 'active_support/inflector'
require 'active_support/core_ext/object'

module SMSBox
  class XMLResponse
    attr_accessor :request
    attr_accessor :command
    attr_accessor :requestUid
    attr_accessor :error

    def error?
      error.present?
    end

    def success?
      not error?
    end

    def initialize
      if self.instance_of? XMLResponse
        raise 'XMLResponse needs to be subclassed'
      end
    end

    def self.from_xml(xml_string)
      doc = Nokogiri::XML(xml_string)
      command = doc.xpath('//SMSBoxXMLReply/command').attr('name').text
      res = instantize(command)
      res.command = command
      res.requestUid = doc.xpath('//SMSBoxXMLReply/requestUid').first.text
      error = doc.xpath('//SMSBoxXMLReply/error')
      unless error.empty?
        res.error = error.attr('type').text
      end
      res
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
