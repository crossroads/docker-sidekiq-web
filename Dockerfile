FROM ruby:2.7.3-alpine

RUN adduser -D -u 1000 deployer
WORKDIR /app/
RUN chown deployer:deployer /app
USER deployer

COPY Gemfile* config.ru /app/
RUN BUNDLE_VERSION=`grep "BUNDLED WITH" -A 1 Gemfile.lock | grep -v "BUNDLED WITH" | cut -d ' ' -f 4-` && \
  gem install bundler:${BUNDLE_VERSION} --no-document && \
  bundle install
RUN ruby -e "require 'securerandom'; File.open('/app/.session.key', 'w') {|f| f.write(SecureRandom.hex(32)) }"

EXPOSE 3000
CMD ["rackup", "config.ru", "-o", "0.0.0.0", "-p", "3000"]
