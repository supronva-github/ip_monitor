FROM ruby:3.2

WORKDIR /app

RUN apt-get update && apt-get install -y iputils-ping

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x /app/.docker/entrypoint.sh

EXPOSE 9292
