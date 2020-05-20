# Base image
FROM ruby:2.6.6-buster AS base

WORKDIR /app

ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock

RUN gem install bundler -no-ri-no-rdoc && \
  bundle config set without 'development test' && \
  bundle install

# Release image
FROM base AS release

ADD . /app

CMD irb -Ilib

# Test image
FROM base AS test

ENV TESTOPTS=--pride

RUN bundle config --delete without && \
  bundle install

CMD rake test
