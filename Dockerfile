FROM ruby:2.7.3-alpine

WORKDIR /sidekiq

COPY Gemfile* ./
COPY config.ru .

RUN gem install bundler:2.2.7 && bundle install
RUN ruby -e "require 'securerandom'; File.open('.session.key', 'w') {|f| f.write(SecureRandom.hex(32)) }"

CMD rackup config.ru -o 0.0.0.0 -p 80 -q
