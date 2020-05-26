FROM ruby:2.7.1-alpine3.11

RUN apk update && \
  apk upgrade && \
  apk add --update --no-cache \
  bash \
  binutils-gold \
  build-base \
  curl-dev \
  file \
  g++ \
  gcc \
  git \
  less \
  libc-dev \ 
  libffi-dev \
  libgcrypt-dev \  
  libstdc++ \
  libxml2-dev \
  libxslt-dev \
  linux-headers \
  make \
  netcat-openbsd \  
  nodejs \
  openssl \
  pkgconfig \
  postgresql-dev \  
  python \  
  sqlite-dev \
  tree \
  tzdata \
  yaml-dev \
  yarn \
  zlib-dev

RUN echo 'alias be="bundle exec"' >> ~/.bashrc
RUN mkdir -p /opt/bin

RUN gem install bundler

ENV APP_PATH /app
WORKDIR $APP_PATH

ENV OPT_BIN /opt/bin
ENV PORT 3000
ENV BUNDLE_PATH /bundle
ENV BUNDLE_BIN /bundle/bin
ENV GEM_HOME /bundle
ENV PATH "${PATH}:${BUNDLE_BIN}:${OPT_BIN}"

RUN chmod -R +x ${OPT_BIN}/

COPY entrypoint.sh /opt/bin/
RUN chmod +x /opt/bin/entrypoint.sh

RUN echo "ruby-2.7.1" > .ruby-version

ENTRYPOINT ["/opt/bin/entrypoint.sh"]

EXPOSE $PORT
CMD bundle exec rails s -p 3000 -b 0.0.0.0
