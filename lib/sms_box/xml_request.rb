require 'nokogiri'

module SMSBox
  class XMLRequest
    attr_accessor :username
    attr_accessor :password

    def command
      raise NotImplementedError.new 'XMLRequest needs to be subclassed'
    end

    def decorate_xml(root)
      root.username username
      root.password password
      root.command command
      root
    end

    def to_xml
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        decorate_xml(xml)
      end
      builder.to_xml
    end
  end
end
