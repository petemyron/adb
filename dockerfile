FROM ubuntu:20.04

ARG ANDROID_TOOLS_VERSION="29.0.6"
ENV ANDROID_TOOLS_VERSION=${ANDROID_TOOLS_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y -q libpcre2-dev linux-headers-generic libusb-dev googletest golang perl cmake gcc libz-dev libgtest-dev libusb-1.0-0-dev curl && \
    curl -Lk -o android-tools.tar.xz https://github.com/nmeum/android-tools/releases/download/${ANDROID_TOOLS_VERSION}/android-tools-${ANDROID_TOOLS_VERSION}.tar.xz && \
    mkdir /android-tools-build && \
    tar xf android-tools.tar.xz -C /android-tools-build/ && \
    cd android-tools-build/android-tools-${ANDROID_TOOLS_VERSION}/ && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    rm -rf /var/lib/apt/lists/*

# Set up insecure default key
RUN mkdir -m 0750 /root/.android
ADD insecure_shared_adbkey /root/.android/adbkey
ADD insecure_shared_adbkey.pub /root/.android/adbkey.pub

# Expose default ADB port
EXPOSE 5037
CMD ["adb", "-a", "-P", "5037", "server", "nodaemon"]
