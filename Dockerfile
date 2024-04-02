FROM node:12-alpine AS node

FROM ruby:2.6-alpine

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

RUN apk add --no-cache \
    git \
    gcompat \
    build-base \
    tzdata \
    yarn \
    sqlite-dev \
    bash \
    postgresql-dev \
    python2

WORKDIR /app

ENV SECRET_KEY_BASE="08898973823f6f1d121ce30fb8adc1c559dcfc08f358cfc0298e4aad81b8c9d798e8249e3a4b26c04255cf8b2d71eaf8eda865d173ae3fe6fb1a599d1b1fa260"
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_ENV production
ENV RACK_ENV production
ENV NODE_ENV production

COPY . /app

RUN cd /app

RUN echo "gem 'sqlite3', '~> 1.3.6'" >> Gemfile && gem install bundler -v 2.4.22 && bundle install --force

VOLUME /app/db/database

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD cd /app && rake 'db:migrate' && bundle exec rails server -b 0.0.0.0
