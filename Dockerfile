FROM ruby:2.7

WORKDIR /app

ADD ./lib/sidekiq-r/version.rb /app/lib/sidekiq-r/
ADD ./exe/sidekiq-r /app/exe/
ADD ./sidekiq-r.gemspec /app
ADD ./Gemfile /app

RUN bundle install

ADD ./ /app

# install the gem locally
RUN rake install

CMD ["./scripts/run_sidekiq-r.sh"]
