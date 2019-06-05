FROM golang:alpine
MAINTAINER golang alpine
ENV CONFIGOR_ENV=development
ADD ./build /build
RUN chmod +x -R /build && \
    mv /build/upx /usr/bin/ && \
    cp /build/docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx