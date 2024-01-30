FROM ruby:3.3.0

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "src/server.rb"]
