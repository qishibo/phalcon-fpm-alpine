FROM php:7.2.5-fpm-alpine3.7

ENV PHALCON_VERSION=3.3.1 \
    PHALCON_EXT_PATH=php7/64bits \
    MEMCACHED_VERSION=3.0.3 \
    PHPREDIS_VERSION=3.1.2 \
    MSGPACK_VERSION=2.0.2 \
    TZ=Asia/Shanghai

RUN echo 'http://mirrors.aliyun.com/alpine/latest-stable/main/' > /etc/apk/repositories\
    && echo 'http://mirrors.aliyun.com/alpine/latest-stable/community/' >> /etc/apk/repositories\
    && apk update\

    && mkdir -p /usr/src/php/ext\
    && chmod o+w /var/log\
    && apk add tzdata libpng-dev\
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime\

    && apk add zlib-dev libmemcached-dev cyrus-sasl-dev\
    && curl -L -o ${PWD}/memcached.tar.gz https://github.com/php-memcached-dev/php-memcached/archive/v${MEMCACHED_VERSION}.tar.gz\
    && tar xzf ${PWD}/memcached.tar.gz\
    && rm ${PWD}/memcached.tar.gz\
    && mv ${PWD}/php-memcached-${MEMCACHED_VERSION} /usr/src/php/ext/memcached\

    && curl -L -o ${PWD}/redis.tar.gz https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz \
    && tar xvf ${PWD}/redis.tar.gz\
    && rm ${PWD}/redis.tar.gz\
    && mv ${PWD}/phpredis-${PHPREDIS_VERSION} /usr/src/php/ext/redis\

    && curl -L -o ${PWD}/msgpack.tar.gz https://github.com/msgpack/msgpack-php/archive/msgpack-${MSGPACK_VERSION}.tar.gz \
    && tar xvf ${PWD}/msgpack.tar.gz\
    && rm ${PWD}/msgpack.tar.gz\
    && mv ${PWD}/msgpack-php-msgpack-${MSGPACK_VERSION} /usr/src/php/ext/msgpack\

    && curl -L -o ${PWD}/phalcon.tar.gz https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz\
    && tar xzf ${PWD}/phalcon.tar.gz\
    && rm ${PWD}/phalcon.tar.gz\
    && mv ${PWD}/cphalcon-${PHALCON_VERSION} /usr/src/php/ext/phalcon\

    && docker-php-ext-configure /usr/src/php/ext/memcached --disable-memcached-sasl\
    && docker-php-ext-install -j $(nproc) memcached redis msgpack /usr/src/php/ext/phalcon/build/${PHALCON_EXT_PATH} \
                                          mysqli pdo_mysql gd zip\

    && rm -rf /usr/src


# health check script
COPY health_check.sh /tmp
HEALTHCHECK --interval=5s --timeout=2s --retries=3 CMD /bin/sh /tmp/health_check.sh

# copy config files
COPY php/php.ini /usr/local/etc/php/
COPY php/www.conf /usr/local/etc/php-fpm.d/

# copy php files
COPY ./ /var/www/html

# docker build -t xxx:xxx .
