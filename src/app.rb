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

  raise "Please, provide the required params." unless params["url"].present? && params["short_code"].present?

  result = url_shortener.shorten(url: params["url"], short_code: params["short_code"])

  result.to_json
end

get '/:short_code' do
  content_type :json

  result = url_shortener.consume(params[:short_code])

  headers['Location'] = result

  halt 304
end
