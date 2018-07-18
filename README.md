# fpc-trunk

[![](https://images.microbadger.com/badges/image/megahertz/fpc-trunk.svg)](https://microbadger.com/images/megahertz/fpc-trunk "Get your own image badge on microbadger.com")

Free Pascal Compiler built from trunk repository using
[alpine linux image](https://hub.docker.com/_/alpine/).

## Usage

```
FROM megahertz/fpc-trunk:3.1.1-39471

COPY program.pas /src/my-program/program.pas
RUN fpc /src/my-program/program.pas
CMD /src/my-program/program

```

## License

Licensed under MIT.
