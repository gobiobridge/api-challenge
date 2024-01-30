require_relative './handlers/api_error'

module Errors
  class MissingRequiredParams < ApiError
    def initialize
      super(message: "Missing required params", status: 400)
    end
  end
end
