FROM golang:alpine
MAINTAINER golang alpine
ENV CONFIGOR_ENV=development
WORKDIR /go/src/
RUN mkdir build
ADD ./build /go/src/build
RUN chmod +x -R /go/src/build && \
    ln -s /go/src/build/upx /usr/bin/upx && \
    cp /go/src/build/docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx