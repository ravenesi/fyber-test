# smhw-event-calendar

## Dependencies
Redis (for Sidekiq)

## Run sidekiq process
```bash
bundle exec sidekiq
```

## Setup repository
```bash
$ cd [path to this repo] && ./bin/setup
```

## Setup crontab
For write to crontab.

$ cd [path to thi repo] && bundle exec whenever -w

## Clear all sidekiq jobs:

```ruby
Sidekiq.redis { |conn| conn.flushdb }
```