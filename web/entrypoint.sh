#!/bin/bash

set -e

if [ -f Gemfile ]; then
  bundle check || bundle install --jobs 8 --binstubs="$BUNDLE_BIN"
fi

exec "$@"
