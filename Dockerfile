FROM golang:alpine
MAINTAINER golang alpine
ENV CONFIGOR_ENV=development
ADD container-files /
RUN chmod +x -R /usr/bin/ && \
    chmod +x /docker-entrypoint.sh && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/latest-stable/community" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update add --no-cache && \
    apk add iproute2 bind-tools net-tools vim curl util-linux bash && \
    apk add --upgrade zig upx
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx