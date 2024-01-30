require_relative './errors'

class BodyParserService
  def self.parse(body)
    payload = body.read

    JSON.parse payload
  rescue JSON::ParserError
    raise Errors::RequestBodyInvalid
  end
end
