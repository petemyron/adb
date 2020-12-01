# build for both arm/x86 with:
#   docker buildx build --platform linux/amd64,linux/arm/v7 -t docker.tmo.io/adb:alpine-3.11 -f adb-alpine.dockerfile --push .

FROM alpine:3.11

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add ca-certificates \
    curl \
    usbutils \
    android-tools@testing

# Set up insecure default key
RUN mkdir -m 0750 /root/.android
ADD insecure_shared_adbkey /root/.android/adbkey
ADD insecure_shared_adbkey.pub /root/.android/adbkey.pub

# Expose default ADB port
EXPOSE 5037
CMD adb -a -P 5037 server nodaemon
