### 使用golang:alpine 
    添加 upx 压缩脚本、docker-entrypoint.sh 添加启动脚本
### 默认 alpine 版本
    80 开放、添加 github.com/jinzhu/configor 配置文件 CONFIGOR_ENV
    建议 upx -1 压缩速度，减少%50左右、-ldflags "-s -w" 减少构建代码量
### 使用 latest
```
FROM mj520/golang AS build
MAINTAINER build
ENV AppName=k8s-test
ADD . /go/src/tmp
WORKDIR /go/src/tmp
RUN go build -ldflags "-s -w" -o build/${AppName} main.go && \
    upx -1 build/${AppName} && chmod +x build/${AppName}
#second
FROM alpine AS prod
ENV AppName=k8s-test
COPY --from=build /go/src/tmp/build/* /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 80
CMD /${AppName}
````
### 输出 upx 帮助信息
    docker run --rm mj520/golang 

### 构建测试快速删除命令
    docker rm $(docker ps -a | grep "Exited" | awk '{print $1 }')
    docker rmi $(docker images | grep "none" | awk '{print $3 }')