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

ENV RAILS_ROOT /usr/src/app/
RUN mkdir -p $RAILS_ROOT 

# Set working directory
WORKDIR $RAILS_ROOT
# Set Rails to run in production
ENV RAILS_ENV='production'
ENV RACK_ENV='production' 
# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test

COPY package.json yarn.lock ./
RUN yarn install

COPY . $RAILS_ROOT

RUN bin/rails assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]