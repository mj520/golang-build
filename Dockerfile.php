FROM registry.cn-hangzhou.aliyuncs.com/mj520/golang-build
ENV PHPIZE_DEPS autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c
RUN echo "https://mirrors.aliyun.com/alpine/v3.15/main" >> /etc/apk/repositories && \
    echo "https://mirrors.aliyun.com/alpine/v3.15/community" >> /etc/apk/repositories && \
    apk update --no-cache && \
    apk search php7 -a && \
    apk add php7 php7-common php7-dev  && \
    apk add $PHPIZE_DEPS
RUN apk add -U tzdata bash ca-certificates libc6-compat libgcc libstdc++ which && \
    ln -s /usr/bin/php-config7 /usr/bin/php-config && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/bin/phpize7 /usr/bin/phpize && \
    php7 -m
#docker build -t php -f Dockerfile.php .