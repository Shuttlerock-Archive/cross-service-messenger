# CrossServiceMessenger

[![CircleCI](https://circleci.com/gh/Shuttlerock/cross-service-messenger.svg?style=svg)](https://circleci.com/gh/Shuttlerock/cross-service-messenger)

# About

Service for communicate apps via AWS SQS.

## Installation in Ruby application

Add this line to your application's Gemfile:

```ruby
gem 'cross-service-messenger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cross-service-messenger

### Setup a service

```ruby
CrossServiceMessenger.setup do |config|
  config.aws_access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  config.aws_region            = ENV['AWS_REGION']
  config.queue_names           = {
    from_some_app: 'some_app_prodution_to_my_app_production',
    to_some_app:   'my_app_production_to_some_app_production',
  }
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CrossServiceMessenger project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Shuttlerock/cross-service-messenger/blob/master/CODE_OF_CONDUCT.md).
