require 'sms_box/xml_request'
require 'sms_box/xml_response'

require 'rest-client'

module SMSBox
  class Client

    attr_accessor :url
    attr_accessor :username, :password

    def request(request)
      unless request.is_a? XMLRequest
        raise "Invalid request"
      end

      request.username = username
      request.password = password
      res = RestClient.post url, request.to_xml, :content_type => "text/xml"
      XMLResponse.from_xml(res)
    end

  end
end
