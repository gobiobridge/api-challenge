require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require_relative 'services/url_shortener_service/base'
require_relative 'services/body_parser_service/base'
require_relative './handlers/api_error'
require_relative 'errors'

Bundler.require(:default)

URL_SHORTENER = UrlShortenerService.new

post '/shorten' do
  content_type :json

  params = BodyParserService.parse(request.body)

  url, short_code = params.dig("url"), params.dig("short_code")

  raise Errors::MissingRequiredParams if url.blank? || short_code.blank?

  result = URL_SHORTENER.shorten(url:, short_code:)

  halt 201, result.to_json
rescue ApiError => e
  halt e.status, e.message
end

get '/:short_code' do
  content_type :json

  result = URL_SHORTENER.consume(params[:short_code])

  headers['Location'] = result

  halt 304
rescue ApiError => e
  halt e.status, e.message
end

get '/:short_code/stats' do
  content_type :json

  result = URL_SHORTENER.stats(params[:short_code])

  halt 200, result.to_json
rescue ApiError => e
  halt e.status, e.message
end
