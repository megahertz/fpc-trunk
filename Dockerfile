FROM frolvlad/alpine-fpc:full

RUN apk add --no-cache make subversion libc-dev

RUN svn co http://svn.freepascal.org/svn/fpc/trunk fpc-src

WORKDIR fpc-src

RUN ln -s /lib /lib64 && \
    ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN mkdir fpc && make all && make install INSTALL_PREFIX=/fpc

FROM alpine:3.10

COPY --from=0 /fpc /usr
RUN apk add --no-cache binutils libc-dev && \
    LIBDIR=$(realpath /usr/lib/fpc/?.?.?) && \
    ln -s ${LIBDIR}/ppcx64 /usr/bin/ppcx64 && \
    ln -s /lib /lib64 && \
    ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 && \
    ${LIBDIR}/samplecfg ${LIBDIR}

