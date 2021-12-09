FROM ruby:2.7

WORKDIR /app

ADD ./lib/sidekiq-err/version.rb /app/lib/sidekiq-err/
ADD ./exe/sidekiq-err /app/exe/
ADD ./sidekiq-err.gemspec /app
ADD ./Gemfile /app

RUN bundle install

ADD ./ /app

# install the gem locally
RUN rake install

CMD ["./scripts/run_sidekiq-err.sh"]
