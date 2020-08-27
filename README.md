# build a modern adb on ubuntu

Ubuntu/Debian packages are always so far behind. 

clone, build with something like:

```
docker build -t adb:29.0.6 --build-arg ANDROID_TOOLS_VERSION=29.0.6 .
``` 

or, for ARM (like a Raspberry Pi):

```
docker buildx build --platform linux/arm/v7 -t adb:29.0.6_arm --build-arg ANDROID_TOOLS_VERSION=29.0.6 .
```
