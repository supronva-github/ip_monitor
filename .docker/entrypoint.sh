#!/bin/bash

echo "Running database setup..."

echo "Setting up the development database..."
  bundle exec rake db:migrate && echo "Development database prepared" || { echo "Failed to prepare development database"; exit 1; }
exec "$@"
