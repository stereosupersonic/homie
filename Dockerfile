FROM ruby:2.6
LABEL maintainer="michael@deimel.de"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list 

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

RUN gem update --system && \
    gem install bundler -v 2.0.2


WORKDIR /usr/src/app

RUN mkdir -p tmp/pids

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN yarn install
RUN bin/rails assets:precompile
COPY . .

ENV RAILS_ENV production
ENV NODE_ENV production
ENV SECRET_KEY_BASE=669bfd9bf5f97461a5b873aac3cebb26df709763d2faf85b2acfd716bd521c06b384d041aba276a7e4b1ae5d50c02054e2a26a1ecb9a6b2167f6d8f0978f7b1d

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]  