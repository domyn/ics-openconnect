FROM docker-registry.lan/debian-base-x86_64:latest

# Define app source mount
VOLUME /mnt/ics-openconnect

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk-linux_x86
ENV PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${PATH}"

RUN apt update && \
    apt install --assume-yes \
        # From .travis.yml
        build-essential autoconf automake libtool groff expect ant \
        # compile fix
        curl python libncurses5 \
        # gnutls fix
        pkgconf libtasn1-6-dev libunistring-dev libunbound-dev libp11-kit-dev autogen texinfo \
        # openconnect
        gettext \
        # My own additions
        git unzip

# Install android NDK
ADD https://nexus.lan/repository/raw-public/files/android-ndk-r16b-linux-x86_64.zip /tmp/
RUN unzip -q -d /opt/android-sdk-linux_x86 /tmp/android-ndk-r16b-linux-x86_64.zip && \
    rm /tmp/android-ndk-r16b-linux-x86_64.zip

# Install sdkmanager
ADD https://nexus.lan/repository/raw-public/files/android-sdk-commandlinetools-linux-6200805_latest.zip /tmp/
RUN unzip -q -d /opt/android-sdk-linux_x86 /tmp/android-sdk-commandlinetools-linux-6200805_latest.zip && \
    rm /tmp/android-sdk-commandlinetools-linux-6200805_latest.zip

# Install SDK tools (based on .travis.yml) - from LAN cache (speed up download...)
# This is equivalent to:
# sdkmanager --sdk_root="${ANDROID_HOME}" --install \
#   "platform-tools"
#   "build-tools;26.0.2"
#   "platforms;android-19"
ADD https://nexus.lan/repository/raw-public/android-sdk/platform-tools_r29.0.6-linux.zip \
    https://nexus.lan/repository/raw-public/android-sdk/build-tools_r26.0.2-linux.zip \
    https://nexus.lan/repository/raw-public/android-sdk/android-19_r04.zip \
    /tmp/

RUN \
# Install "platform-tools" - /opt/android-sdk-linux_x86/platforms-tools
    unzip -q -d /opt/android-sdk-linux_x86 /tmp/platform-tools_r29.0.6-linux.zip && \
    rm /tmp/platform-tools_r29.0.6-linux.zip && \
# Install "build-tools;26.0.2" - /opt/android-sdk-linux_x86/build-tools/26.0.2
    mkdir -p /opt/android-sdk-linux_x86/build-tools && \
    unzip -q -d /tmp/ /tmp/build-tools_r26.0.2-linux.zip && \
    mv /tmp/android-8.1.0 /opt/android-sdk-linux_x86/build-tools/26.0.2 && \
    rm /tmp/build-tools_r26.0.2-linux.zip && \
# Install "platforms;android-19" - /opt/android-sdk-linux_x86/platforms/android-19
    mkdir -p /opt/android-sdk-linux_x86/platforms && \
    unzip -q -d /tmp/ /tmp/android-19_r04.zip && \
    mv /tmp/android-4.4.2 /opt/android-sdk-linux_x86/platforms/android-19 && \
    rm /tmp/android-19_r04.zip




# RUN mkdir "${ANDROID_HOME}/lib" "${ANDROID_HOME}/bin" && \
#     touch "${ANDROID_HOME}/notice.txt" "${ANDROID_HOME}/source.properties"
# Setup android SDK-19
# Accept licences
RUN yes | sdkmanager --sdk_root="${ANDROID_HOME}" --licenses
#RUN alias sdkmanager='sdkmanager --sdk_root="${ANDROID_HOME}"'



# Install Gradle
# Downloading https://services.gradle.org/distributions/gradle-4.1-all.zip
# Unzipping /root/.gradle/wrapper/dists/gradle-4.1-all/bzyivzo6n839fup2jbap0tjew/gradle-4.1-all.zip to /root/.gradle/wrapper/dists/gradle-4.1-all/bzyivzo6n839fup2jbap0tjew
# Set executable permissions for: /root/.gradle/wrapper/dists/gradle-4.1-all/bzyivzo6n839fup2jbap0tjew/gradle-4.1/bin/gradle

# Inject custom files
COPY files/ /

# Default to source code directory
WORKDIR /mnt/ics-openconnect

CMD /root/build.sh
