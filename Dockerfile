FROM alpine:3.16.0

RUN apk add --update autoconf automake build-base libaio-dev libtool make mysql-dev pkgconfig

ADD https://github.com/akopytov/sysbench/archive/refs/tags/1.0.20.tar.gz /tmp/sysbench/

WORKDIR /tmp/sysbench

RUN tar -xf 1.0.20.tar.gz

WORKDIR /tmp/sysbench/sysbench-1.0.20

RUN sh autogen.sh && \
  sh configure && \
  make -j && \
  make install

WORKDIR /

RUN rm -rf /tmp/sysbench

ENTRYPOINT [ "sysbench" ]
CMD [ "--help" ]
