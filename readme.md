### 使用golang:alpine 
    添加 upx 压缩脚本、docker-entrypoint.sh 添加启动脚本
### 默认 alpine 版本
    80 开放、添加 github.com/jinzhu/configor 配置文件 CONFIGOR_ENV
    建议 upx -1 压缩速度，减少%50左右、-ldflags "-s -w" 减少构建代码量
        使用go mod 是 代码中含有vendor 请使用参数 -mod=vendor
### 使用 latest
```
FROM registry.cn-hangzhou.aliyuncs.com/mj520/golang-build AS build
MAINTAINER build
ENV AppName=main PackagePath=path/relative
# PackagePath is a directory relative to main.go to ${GOPATH}/src
ADD . ${GOPATH}/src/${PackagePath}
WORKDIR ${GOPATH}/src/${PackagePath}
RUN go build  -ldflags "-s -w" -o /build/${AppName} main.go && \
    upx -1 /build/${AppName} && chmod +x /build/${AppName}
#&& mv your need file and directory to /build/
#second
FROM registry.cn-hangzhou.aliyuncs.com/mj520/alpine:3.16 AS prod
ENV AppName=main
ENV TZ=Asia/Shanghai
RUN echo "https://mirrors.aliyun.com/alpine/v3.16/main" > /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.16/community" >> /etc/apk/repositories && \
    #时区 ca-certificates 必须 不然证书相关会有问题 libc6-compat libgcc libstdc++ cgo 建议安装
    apk --update add --no-cache && apk add -U tzdata bash ca-certificates && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY --from=build /build/* /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
#your need Specify startup parameters
CMD /${AppName} 
````
### 输出 upx 帮助信息
    docker run --rm mj520/golang 

### 构建测试快速删除命令
    docker rm $(docker ps -a | grep "Exited" | awk '{print $1 }')
    docker rmi $(docker images | grep "none" | awk '{print $3 }')