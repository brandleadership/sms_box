require "sms_box/version"
require "sms_box/response_exception"
require "sms_box/xml_request"
require "sms_box/xml_response"
require "sms_box/websend_request"
require "sms_box/websend_response"
require "sms_box/client"

module SMSBox
  def self.client url, opts = {}
    Client.new.tap do |client|
      client.url = url
      opts.each do |key, value|
        m = "#{key}="
        client.send(m, value) if client.respond_to?(m)
      end
      yield(client) if block_given?
    end
  end
end
