FROM ubuntu:14.04
MAINTAINER Mikhail Gorelov

# Install the required libraries
RUN \
dpkg --add-architecture i386 && \
apt-get update && \
apt-get install -y curl xz-utils lib32z1 lib32ncurses5 lib32bz2-1.0 libstdc++6:i386 g++

# Configure environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle
ENV ANDROID_HOME /android
ENV NODEJS /nodejs
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$NODEJS/bin

# Create a non-root user and make it owner of home folder
RUN \
groupadd -r -g 1000 nativescript && useradd -r -u 1000 -g 1000 -G 0 nativescript && \
mkdir /home/nativescript && chown -R nativescript /home/nativescript && \
# Create folders for AndroidSDK and NodeJS
mkdir $ANDROID_HOME && chown -R nativescript $ANDROID_HOME && \
mkdir $NODEJS && chown -R nativescript $NODEJS

# Install JKD 8
RUN \
apt-get install -y software-properties-common && \
add-apt-repository ppa:webupd8team/java && \
apt-get update && \

echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \

apt-get install -y oracle-java8-installer

# Switch to non-root user
USER nativescript

# Install AndroidSDK (as non-root user)
RUN curl https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz --strip-components=1 -C $ANDROID_HOME
RUN echo y | $ANDROID_HOME/tools/android update sdk --filter platform-tools,android-23,build-tools-23.0.2,extra-android-m2repository,extra-google-m2repository,extra-android-support --all --no-ui

# Install Node.js & NativeScript (as non-root user)
RUN \
curl https://nodejs.org/dist/v4.4.4/node-v4.4.4-linux-x64.tar.xz | tar xJ --strip-components=1 -C $NODEJS && \
npm install nativescript -g --unsafe-perm

VOLUME /home/nativescript
WORKDIR /home/nativescript
