FROM golang:alpine
MAINTAINER golang alpine
ENV CONFIGOR_ENV=development
ADD . /go/src/tmp
WORKDIR /go/src/tmp
RUN chmod +x -R build && \
    mv build/upx /usr/bin/ && \
    cp build/docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx