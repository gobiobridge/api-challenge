require_relative '../api_error'

class UrlShortenerService
  @@shorters = {}
  @@short_code_regex = /^[0-9a-zA-Z_]{4,}$/

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

  def shorten(url:, short_code:)
    raise Errors::ShortCodeFailedRegex unless @@short_code_regex.match?(short_code)
    raise Errors::ShortCodeAlreadyTaken if @@shorters.dig(short_code).present?

    @@shorters[short_code] = {
      url:,
      start_date: Time.now,
      last_seen_date: nil,
      redirect_count: 0
    }

    { short_code: }
  end

  def consume(short_code)
    raise Errors::ShortCodeNotRegistered unless @@shorters.dig(short_code).present?

    @@shorters[short_code][:redirect_count] += 1
    @@shorters[short_code][:last_seen_date] = Time.now

    @@shorters[short_code][:url]
  end

  def stats(short_code)
    raise Errors::ShortCodeNotRegistered unless @@shorters.dig(short_code).present?

    {
      start_date: @@shorters[short_code][:start_date],
      last_seen_date: @@shorters[short_code][:last_seen_date],
      redirect_count: @@shorters[short_code][:redirect_count]
    }
  end
end
