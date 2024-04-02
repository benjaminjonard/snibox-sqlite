FROM ruby:2.6-alpine

RUN apk add --no-cache \
    build-base \
    tzdata \
    nodejs \
    yarn \
    sqlite-dev \
    bash \
    postgresql-dev

WORKDIR /app

#ENV GIT_HASH f06c0eba941862203026531c27c7009f8d978bfb

ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_ENV production
ENV RACK_ENV production
ENV NODE_ENV production

COPY . /app

RUN mv -n /app/snibox /app

RUN echo "gem 'sqlite3', '~> 1.3.13'" >> Gemfile && gem install bundler -v 2.4.22 && bundle install

VOLUME /app/db/database

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD cd /app && rake 'db:migrate' && bundle exec rails server -b 0.0.0.0
