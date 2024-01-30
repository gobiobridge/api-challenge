require_relative '../../handlers/api_error'

module Errors
  class ShortCodeNotRegistered < ApiError
    def initialize
      super(message: "The short code cannot be found in the system", status: 400)
    end
  end

  class ShortCodeAlreadyTaken < ApiError
    def initialize
      super(message: "The short code is already taken", status: 409)
    end
  end

  class ShortCodeFailedRegex < ApiError
    def initialize
      super(message: "The short code failed to match the required format", status: 422)
    end
  end
end
