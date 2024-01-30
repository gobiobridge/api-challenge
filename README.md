# api-challenge
The solution for this challenge is written in [ruby 3.3.0](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/), uses [sinatra](https://sinatrarb.com/) for http serving and [rspec](https://rspec.info/) for testing it.<br>
Please enjoy!

## First Steps
There are 2 ways of running/testing the server:
- `Docker` (recommended to avoid having to download different ruby versions and gems on your local machine)
- `Local`

## 1. Docker
If you are going to run it via docker, please make sure you have the following requirements:
- `Docker`
- `Docker compose`

### 1.1 Running the server
To start the server, please run the following in the root directory:
```bash
docker compose up server
```

Now you are all setup and ready for running your http requests!

### 1.2 Testing
To test the server with docker, please run the following in the root directory:
```bash
docker compose up test
```

## 2. Local

If you are going to run it locally, please make sure you have the following requirements:
- `Ruby 3.3.0`
- `Bundler 2.5.*`

### 2.1 Installation
With that, please run the following in the root directory:

```bash
bundle install
```

### 2.2 Running the server
To start the server, please run the following in the root directory:

```bash
bundle exec ruby src/server.rb
```

Now you are all setup and ready for running your http requests!

### 2.3 Testing
To test the server locally, please run the following in the root directory:
```bash
bundle exec rspec
```
