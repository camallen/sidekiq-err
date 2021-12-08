# sidekiq_status

Status of your sidekiq system - useful for Kubernetes Liveness probes

This gem provides a binary `sidekiq_status` to enumerate the state of a running sidekiq system.

Heavily inspired by `sidekiqctl`, sadly removed in [sidekiq v6](https://github.com/mperham/sidekiq/blob/74ccba6c68b1df31d615991fb2749fc19de8fbf7/bin/sidekiqctl) - RIP.

This binary will return a 0 exit code if it detects a sidekiq process and a non-zero exit code if no sidekiq process is running.

The above can be used in combination with a Kubernetes liveness probe, e.g.

``` yaml
livenessProbe:
  exec:
    command:
      - sidekiq_stats
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq_status'
```

And then execute:

`$ bundle install`

Or install it yourself as:

`$ gem install sidekiq_status`

## Usage

### Print the default view (processes) of your sidekiq installation

`$ sidekiq_status`

### Print 'all' section view

`$ sidekiq_status all`

### See the usage message, including all known sections

`$ sidekiq_status --help`

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
docker-compose run --rm sidekiq_status bash
```

Then, run `bundle exec rspec` or `rake spec` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/camallen/sidekiq_status. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/camallen/sidekiq_status/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the sidekiq_status project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/camallen/sidekiq_status/blob/master/CODE_OF_CONDUCT.md).
