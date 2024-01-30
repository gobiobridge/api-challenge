# app.rb
require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require_relative 'services/url_shortener_service'
Bundler.require(:default)

url_shortener = UrlShortenerService.new

post '/shorten' do
  content_type :json

  data = JSON.parse(request.body.read) if request.body.read.present?

  raise "Please, provide the required params." unless data&["url"].present? && data&["short_code"].present?

  result = url_shortener.shorten(url: data["url"], short_code: data["short_code"])

  result.to_json
end
