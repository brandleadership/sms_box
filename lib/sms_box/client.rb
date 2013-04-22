require 'sms_box/xml_request'
require 'sms_box/xml_response'

require 'rest-client'

module SMSBox
  class Client

    attr_accessor :url
    attr_accessor :username, :password

    def request!(request)
      response = request(request)
      if response.error?
        raise ResponseException.new(response.error, response)
      end
      response
    end

    def request(request)
      unless request.is_a? XMLRequest
        raise "Invalid request"
      end

      request.username = username
      request.password = password
      xml = RestClient.post url, request.to_xml, :content_type => "text/xml"
      response = XMLResponse.from_xml(xml)
      response.request = request
      response
    end

  end
end
