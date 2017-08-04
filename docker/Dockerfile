# Version: 0.0.1

FROM risingstack/alpine:3.4-v6.11.1-4.5.1

MAINTAINER Paul Nebel "paul@nebel.io"
ENV REFRESHED_AT 2017_07_24
LABEL name="Customised Hot Potato Player game for Hydra microservices"
LABEL version="1.0"

# Add the relevant packages so that we can 'npm install'
RUN apk update -q &&\
    apk add --no-cache make gcc g++ python &&\
    apk upgrade

# Create "dogfish" user
RUN addgroup appuser &&\
    adduser -G appuser -g "App User" -h /home/dogfish -s /bin/ash -D dogfish &&\
    chown -R dogfish:appuser /usr/local

# Set up some semblance of an environment
WORKDIR /home/dogfish
ENV HOME /home/dogfish
RUN mkdir /home/dogfish/app &&\
    mkdir /home/dogfish/.npm-global &&\
    chown -R dogfish:appuser /home/dogfish &&\
    echo "export PATH=~/.npm-global/bin:$PATH" >> /home/dogfish/.profile

USER dogfish

RUN npm config set prefix '~/.npm-global' &&\
    source /home/dogfish/.profile &&\
    npm install -g npm &&\
    npm install -g nodemon &&\
    npm install -g hydra-cli &&\
    npm config set python /usr/bin/python &&\
    npm cache clear

WORKDIR /home/dogfish/app
VOLUME /home/dogfish/app