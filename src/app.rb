# app.rb
require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require_relative 'services/url_shortener_service'
Bundler.require(:default)

url_shortener = UrlShortenerService.new

post '/shorten' do
  content_type :json

  params = JSON.parse request.body.read

  if params.dig("url").blank? || params.dig("short_code").blank?
    return halt 400, "Missing required params"
  end

  result = url_shortener.shorten(url: params["url"], short_code: params["short_code"])

  result.to_json
end

get '/:short_code' do
  content_type :json

  result = url_shortener.consume(params[:short_code])

  headers['Location'] = result

  halt 304
end

get '/:short_code/stats' do
  content_type :json

  result = url_shortener.stats(params[:short_code])

  result.to_json
end
