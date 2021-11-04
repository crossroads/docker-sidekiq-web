FROM ruby:2.7.3-alpine

RUN adduser -D -u 1000 deployer
WORKDIR /app/
RUN chown deployer:deployer /app
USER deployer

COPY Gemfile* config.ru /app/
RUN gem install bundler:2.2.27 && bundle install
RUN ruby -e "require 'securerandom'; File.open('/app/.session.key', 'w') {|f| f.write(SecureRandom.hex(32)) }"

CMD ["rackup", "config.ru", "-o 0.0.0.0", "-p 80", "-q"]
