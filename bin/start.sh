#!/usr/bin/env bash

bundle install -j4 --without development test
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec passenger stop --port 3000
RAILS_ENV=production bundle exec passenger start -p 3000 -e production -d  --max-pool-size 3
