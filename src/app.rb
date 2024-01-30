require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require_relative 'services/url_shortener_service/base'
require_relative './handlers/api_error'

Bundler.require(:default)

url_shortener = UrlShortenerService.new

post '/shorten' do
  content_type :json

  params = JSON.parse request.body.read

  url, short_code = params.dig("url"), params.dig("short_code")

  if url.blank? || short_code.blank?
    return halt 400, "Missing required params"
  end

  result = url_shortener.shorten(url:, short_code:)

  halt 201, result.to_json
rescue ApiError => e
  halt e.status, e.message
end

get '/:short_code' do
  content_type :json

  result = url_shortener.consume(params[:short_code])

  headers['Location'] = result

  halt 304
rescue ApiError => e
  halt e.status, e.message
end

get '/:short_code/stats' do
  content_type :json

  result = url_shortener.stats(params[:short_code])

  halt 200, result.to_json
rescue ApiError => e
  halt e.status, e.message
end
