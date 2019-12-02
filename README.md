# fpc-trunk

[![](https://images.microbadger.com/badges/image/megahertz/fpc-trunk.svg)](https://microbadger.com/images/megahertz/fpc-trunk "Get your own image badge on microbadger.com")
![](https://github.com/megahertz/fpc-trunk/workflows/.github/workflows/main.yml/badge.svg)

Free Pascal Compiler built weekly from trunk repository using
[alpine linux image](https://hub.docker.com/_/alpine/).

This image is built from trunk repository which contains all fixes and
improvements since the last official release, so please try it if
you have any problems. Of course, it may also contain new bugs.

If you need the latest stable FPC image instead of dev build, try the
[frolvlad's image](https://hub.docker.com/r/frolvlad/alpine-fpc/).

## Usage

1. Create a program, for example:

    ```pascal
    { app.pas }
    program app;

    begin
      WriteLn('Hi from docker');
    end.

    ```

2. Create a Dockerfile

    ```dockerfile
    # Dockerfile
    FROM megahertz/fpc-trunk:3.1.1-39472

    COPY app.pas /src/my-program/app.pas
    RUN fpc /src/my-program/app.pas
    CMD /src/my-program/app

    ```

3. Build the image and run

    ```bash
    docker build . -t app
    docker run app
    ```

### Troubleshooting

#### My app can't be run on another alpine image

In most cases, the app can't find ld-linux-x86-64.so.2. There are two
ways to fix that:

- Add to your Dockerfile for the target image:

    ```dockerfile
    RUN ln -s /lib /lib64 && \
        ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2
    ```

- Compile your app with the following FPC flag:

    `-FL/lib/libc.musl-x86_64.so.1`
