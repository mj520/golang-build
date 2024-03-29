FROM registry.cn-hangzhou.aliyuncs.com/mj520/golang-build:golang-alpine3.16
MAINTAINER golang-alpine3.16
ENV CONFIGOR_ENV=development
ADD container-files /
RUN chmod +x -R /usr/bin/ && \
    chmod +x /docker-entrypoint.sh && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/community" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update add --no-cache && \
    apk add iproute2 bind-tools net-tools vim curl util-linux bash && \
    apk add --upgrade zig upx
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx