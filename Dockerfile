FROM golang:alpine
MAINTAINER golang alpine
ENV CONFIGOR_ENV=development
ADD ./build /build
RUN chmod +x -R /build && \
    mv /build/upx /usr/bin/ && \
    cp /build/docker-entrypoint.sh / && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk --update add --no-cache && \
    apk add iproute2 bind-tools net-tools vim curl util-linux bash && \
    mv /build/gcvis /usr/bin/ 
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx