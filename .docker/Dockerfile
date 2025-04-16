FROM ruby:3.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x /app/.docker/entrypoint.sh

EXPOSE 9292

ENTRYPOINT ["/app/.docker/entrypoint.sh"]

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
