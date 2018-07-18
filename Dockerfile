FROM frolvlad/alpine-fpc:full

ARG PREVIOUS_REVISION=HEAD

RUN apk add --no-cache make subversion libc-dev

RUN svn co http://svn.freepascal.org/svn/fpc/trunk fpc-src

WORKDIR fpc-src

RUN ln -s /lib /lib64 && \
    ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

RUN mkdir fpc && make all && make install INSTALL_PREFIX=/fpc

RUN svn info --show-item revision > /fpc/lib/fpc/CHANGELOG && \
    svn log -r ${PREVIOUS_REVISION}:HEAD | tail -n 50 >> /fpc/lib/fpc/CHANGELOG

FROM alpine:3.8

COPY --from=0 /fpc /usr
RUN apk add --no-cache binutils libc-dev && \
    LIBDIR=realpath /usr/lib/fpc/?.?.? && \
    ln -s ${LIBDIR}/ppcx64 /usr/bin/ppcx64 && \
    ln -s /lib /lib64 && \
    ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 && \
    ${LIBDIR}/samplecfg ${LIBDIR}

