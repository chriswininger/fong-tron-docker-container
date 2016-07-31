From ubuntu:16.04
MAINTAINER Chris Wininger <chris.wininger@gmail.com>--

# install run time dependencies
RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y git
RUN npm install -g gulp
RUN npm install -g bower

# for gulp init file which assumes node
RUN ln -s /usr/bin/nodejs /usr/local/bin/node

# need to allow bower to run as root (would be better set this container up to not use root)
RUN echo '{ "allow_root": true }' > /root/.bowerrc

# fetch and initalize the project
RUN git clone https://github.com/chriswininger/FongPhone.git
WORKDIR /FongPhone
RUN git checkout fong-tron-1.0.0
RUN npm install
RUN gulp initialize
RUN cp ./server/serverConfig.json.sample ./server/serverConfig.json

# container settings
EXPOSE 3002
CMD ["node", "./server/galleryServer.js"]

