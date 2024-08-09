FROM registry.cn-hangzhou.aliyuncs.com/mj520/golang-build:golang-alpine3.16
MAINTAINER golang-alpine3.16
ENV CONFIGOR_ENV=development
ADD container-files /
RUN chmod +x -R /usr/bin/ && \
    chmod +x /build/* && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/community" >> /etc/apk/repositories && \
    apk add --no-cache iproute2 bind-tools net-tools vim curl util-linux bash upx
ENTRYPOINT [ "/build/docker-entrypoint.sh" ]
EXPOSE 80
CMD upx
#apk update --no-cache 和 apk add --no-cache 都会更新索引 移除zig 需要再加