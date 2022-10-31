FROM ruby:2.7.4
ENV LANG=C.UTF-8
ENV LANGUAGE=en_US:

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  nodejs

WORKDIR /myapp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . /myapp