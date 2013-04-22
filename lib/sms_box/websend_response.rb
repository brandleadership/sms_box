module SMSBox
  class WebsendResponse < XMLResponse

    attr_accessor :receiver_status

    def initialize
      super
      self.receiver_status = []
    end

    def command_data=(command_nodeset)
      super
      self.receiver_status = command_nodeset.xpath('receiver').map do |receiver|
        { :receiver => receiver.text, :status => receiver[:status] }
      end
    end
  end
end
