#!/usr/bin/env sh

# Prefix `bundle` with `exec` so unicorn shuts down gracefully on SIGTERM (i.e. `docker stop`)
exec bundle exec rails server -b 0.0.0.0; # -e $RAILS_ENV
