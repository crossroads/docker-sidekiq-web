FROM ruby:2.7.3-alpine

WORKDIR /sidekiq

COPY Gemfile* ./
COPY config.ru .

RUN bundle install

CMD rackup config.ru -o 0.0.0.0 -p 3030 -q
