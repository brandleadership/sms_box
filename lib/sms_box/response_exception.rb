module SMSBox
  class ResponseException < Exception
    attr_accessor :error
    attr_accessor :response

    def initialize(error, response)
      super(error)
      self.response = response
    end

  end
end
