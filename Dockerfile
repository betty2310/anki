FROM ruby:3.2.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update && \
    apt-get install build-essential -y --no-install-recommends \
    vim \
    git \
    gnupg2 \
    curl \
    wget \
    nodejs \
    patch \
    ruby-dev \
    zlib1g-dev \
    liblzma-dev \
    libmariadb-dev

ENV BUNDLER_PATH=/bundle BUNDLE_BIN=/bundle/bin GEM_HOME=/bundle

ENV PATH="${BUNDLE_BIN}:${PATH}"

ARG BUNDLER_VERSION=2.4.19

RUN gem install bundler:${BUNDLER_VERSION}

RUN bundle install --path=${BUNDLER_PATH}

COPY . /app

RUN chmod +x wait-for-it.sh

RUN chmod a+x entrypoint.sh
