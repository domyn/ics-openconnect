FROM docker-registry.lan/debian-base-x86_64:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install --assume-yes \
        build-essential \
        git autoconf automake libtool \
        android-sdk

# Install android SDK
RUN ...
ENV ANDROID_HOME=???


# Install android NDK

VOLUME /mnt/ics-openconnect

CMD /root/build.sh
