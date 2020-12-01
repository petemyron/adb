# build a modern adb on alpine

Ubuntu/Debian packages are always so far behind, so use Alpine.

clone, build with something like:

```
docker buildx build --platform linux/amd64,linux/arm/v7 -t adb . [--load|--push]
```

## enable an arm buildx builder
* `docker buildx create --name test --platform linux/armv7`
* `docker buildx inspect test --bootstrap`
