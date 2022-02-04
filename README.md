# sidekiq-err ![Build Status](https://github.com/camallen/sidekiq-err/actions/workflows/run_tests_CI.yml/badge.svg?branch=master)


Report the status of your sidekiq system

This gem provides a binary `sidekiq-err` to enumerate the state of a running sidekiq system.

Heavily inspired by `sidekiqctl`, sadly removed in [sidekiq v6](https://github.com/mperham/sidekiq/blob/74ccba6c68b1df31d615991fb2749fc19de8fbf7/bin/sidekiqctl) - RIP.

This binary will return a 0 exit code if it detects a sidekiq process and a non-zero exit code if no sidekiq process is running.

The above can be used in combination with a Kubernetes liveness probe as it returns non zero exit code if sidekiq is not running, e.g.

``` yaml
livenessProbe:
  exec:
    command:
      - sidekiq-err --alive $HOSTNAME
```

$HOSTNAME env var in a pod correlates to the default name that Sidekiq uses to identify the sever processes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-err'
```

And then execute:

`$ bundle install`

Or install it yourself as:

`$ gem install sidekiq-err`

## Usage

This gem depends on your Sidekiq setup, e.g. REDIS_URL etc, please ensure this is configured correctly https://github.com/mperham/sidekiq/wiki/Using-Redis

### Test if a Sidekiq server is running

`$ sidekiq-err --alive expected-process-name`

This returns a non-zero exit code if sidekiq isn't running or Redis not available


### Print the default view (processes) of your sidekiq server

`$ sidekiq-err --report`

### Print 'all' section view

`$ sidekiq-err --report all`

### See the usage message, including all known sections

`$ sidekiq-err --help`

## Development

### Docker & Docker-compose

``` sh
# build the test container image
docker-compose build
# launch a container to run the gem cmd against a live sidekiq system (see docker-compose.yml for server)
docker-compose up
```

Alternatively

``` sh
# get a bash session in the docker container
docker-compose run --rm sidekiq-err bash
```

Then, run `bundle exec rspec` or `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/camallen/sidekiq-err. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/camallen/sidekiq-err/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the sidekiq-err project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/camallen/sidekiq-err/blob/master/CODE_OF_CONDUCT.md).
