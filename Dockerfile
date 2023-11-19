FROM ubuntu:23.04

## Github Pages/Jekyll is based on Ruby
ENV RBENV_ROOT /usr/local/src/rbenv
ENV RUBY_VERSION 3.1.2
ENV PATH ${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH

ENV NODE_VERSION 20

RUN apt-get update

RUN apt-get -y install git \
  curl \
  bash \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev \
  libdb-dev \
  apt-utils \
  webp 

## Install Nodejs
RUN  curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash \
  && apt-get install -y nodejs

# "Install rbenv to manage Ruby versions"
# "DOCs on how to install https://github.com/rbenv/rbenv"
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
  && git clone https://github.com/rbenv/ruby-build.git \
  ${RBENV_ROOT}/plugins/ruby-build \
  && ${RBENV_ROOT}/plugins/ruby-build/install.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN rbenv install ${RUBY_VERSION} \
  && rbenv global ${RUBY_VERSION}

# "Install the version of Jekyll that GitHub Pages supports"
# "Based on: https://pages.github.com/versions/"
RUN gem install jekyll -v '3.9.3'

 