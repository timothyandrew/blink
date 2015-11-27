#!/usr/bin/env bash

bundle install -j4 --without development test
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake assets:precompile
RAILS_ENV=production RACK_ENV=production PORT=3000 foreman start
