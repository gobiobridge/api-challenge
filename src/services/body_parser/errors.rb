require_relative '../../handlers/api_error'

module Errors
  class RequestBodyInvalid < ApiError
    def initialize
      super(message: "The request body is invalid", status: 400)
    end
  end
end
