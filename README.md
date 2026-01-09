# xdk-docker

Collection of Dockerfiles to build docker images containing the Xbox 360 Software Development Kit (XDK).

> [!IMPORTANT]
> This repository only contains Dockerfiles, prebuilt images are not provided!

> [!IMPORTANT]
> These images don't provide any build system other than `make`. MSBuild (so Visual Studio) is not supported.

## Images

### Light

Alpine image with `make` and `wine` containing a minimal set of files from the XDK to build applications and libraries. It is built with continuous integration (CI) in mind and focuses on being small.

This image might not contain everything you need to build your application or library. For example, if your application uses DirectX to render graphics and compiles HLSL shaders during a build step, you can add a `COPY` line to add the `fxc.exe` tool (and the potential DLLs it might depend on) and uncomment the `COPY` lines for `d3d9.lib`, `d3dx9.lib` and `xgraphics.lib`.

### Full

Alpine image with `bash`, `make` and `wine` containing the **entire** XDK. It is meant to act as a development environment and is therefore a **lot bigger** than the light version.

This image should contain everything you need to build your application or library but should not be used in environments where image size and bandwidth matter a lot like CI.

## Building

Both images require an `XDK` build argument which points to where your XDK is installed. They were only tested with the XDK version `2.0.21256.17`, but any `2.0.21256.XX` version should work.

Example:

```sh
docker build \
    -t xdk-docker:light \
    --build-arg XDK="<path_to_xdk>" \
    -f light.Dockerfile \
    .
```
