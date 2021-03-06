FROM ruby:2.6
LABEL maintainer="michael@deimel.de"

# Define basic environment variables
ENV NODE_ENV production
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE=669bfd9bf5f97461a5b873aac3cebb26df709763d2faf85b2acfd716bd521c06b384d041aba276a7e4b1ae5d50c02054e2a26a1ecb9a6b2167f6d8f0978f7b1d

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -  
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list 

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn \
  cron \
  speedtest-cli 

RUN gem update --system && \
    gem install bundler -v 2.0.2

RUN mkdir -p /app
WORKDIR /app

# We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock ./
# $(nproc) runs bundler in parallel with the amount of CPUs processes 
RUN bundle config set without development test && bundle check || bundle install -j $(nproc)

# caching yarn
COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./

RUN RAILS_ENV=production bin/rake assets:precompile

EXPOSE 3000

ENTRYPOINT /app/entrypoint.sh
