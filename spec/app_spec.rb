require 'rack/test'
require_relative '../src/app'

RSpec.describe 'Server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context 'POST /shorten' do
    it 'returns 201 when valid params are provided' do
      post '/shorten', { url: 'http://example.com', short_code: 'example' }.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(201)
      expect(last_response.body).to include({ short_code: 'example' }.to_json)
    end

    it 'returns 422 when an invalid short_code is provided' do
      post '/shorten', { url: 'http://example.com', short_code: '(example$' }.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(422)
      expect(last_response.body).to eq("The short code failed to match the required format")
    end

    it 'returns 404 when required params are missing' do
      post '/shorten', { url: 'http://example.com' }.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq('Missing required params')
    end

    it 'returns 409 when short_code is already taken' do
      post '/shorten', { url: 'http://example.com', short_code: 'example' }.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(409)
      expect(last_response.body).to eq('The short code is already taken')
    end
  end

  context 'GET /:short_code' do
    it 'returns 304 when valid short_code is provided' do
      get '/example'
      expect(last_response.status).to eq(304)
      expect(last_response.headers['Location']).to eq('http://example.com')
    end

    it 'returns 404 when invalid short_code is provided' do
      get '/invalid_short_code'
      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq('The short code could not be found in the system')
    end
  end

  context 'GET /:short_code/stats' do
    it 'returns 200 when valid short_code is provided' do
      get '/example/stats'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('start_date')
      expect(last_response.body).to include('last_seen_date')
      expect(last_response.body).to include('redirect_count')
    end

    it 'returns 404 when invalid short_code is provided' do
      get '/invalid_short_code/stats'
      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq('The short code could not be found in the system')
    end
  end
end
