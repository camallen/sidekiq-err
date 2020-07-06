FROM ruby:2.6

WORKDIR /app

ADD ./lib/sidekiq_status/version.rb /app/lib/sidekiq_status/
ADD ./sidekiq_status.gemspec /app
ADD ./Gemfile /app
ADD ./Gemfile.lock /app

RUN bundle install

ADD ./ /app

CMD ["bundle", "exec", "foreman", "start"]