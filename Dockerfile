# php7.2 fpm alpine phalcon redis memcached yar
# FROM php:7.1-fpm-alpine3.4
FROM php:7.2-fpm-alpine3.7

RUN echo 'http://mirrors.aliyun.com/alpine/latest-stable/main/' > /etc/apk/repositories; \
    echo 'http://mirrors.aliyun.com/alpine/latest-stable/community/' >> /etc/apk/repositories; \
    apk update;


# fix some path error
RUN mkdir -p /usr/src/php/ext

#------------------------------------------------------
# install php phalcon extension
ARG PHALCON_VERSION=3.3.1
ARG PHALCON_EXT_PATH=php7/64bits

RUN curl -L -o ${PWD}/phalcon.tar.gz https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz\
    && tar xzf ${PWD}/phalcon.tar.gz\
    && rm ${PWD}/phalcon.tar.gz\
    && mv ${PWD}/cphalcon-${PHALCON_VERSION} /usr/src/php/ext/phalcon\
    && docker-php-ext-install -j $(nproc) /usr/src/php/ext/phalcon/build/${PHALCON_EXT_PATH}

#------------------------------------------------------
# install php memcached extension
ENV MEMCACHED_VERSION 3.0.3

RUN apk add zlib-dev libmemcached-dev cyrus-sasl-dev\
    && curl -L -o ${PWD}/memcached.tar.gz https://github.com/php-memcached-dev/php-memcached/archive/v${MEMCACHED_VERSION}.tar.gz\
    && tar xzf ${PWD}/memcached.tar.gz\
    && rm ${PWD}/memcached.tar.gz\
    && mv ${PWD}/php-memcached-${MEMCACHED_VERSION} /usr/src/php/ext/memcached\
    && docker-php-ext-configure /usr/src/php/ext/memcached --disable-memcached-sasl\
    && docker-php-ext-install -j $(nproc) memcached

#------------------------------------------------------
# install php pdo_mysql mysqli extension
RUN docker-php-ext-install mysqli pdo_mysql

#------------------------------------------------------
# install phpredis extension
ENV PHPREDIS_VERSION 3.1.2

RUN curl -L -o ${PWD}/redis.tar.gz https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz \
    && tar xvf ${PWD}/redis.tar.gz\
    && rm ${PWD}/redis.tar.gz\
    && mv ${PWD}/phpredis-${PHPREDIS_VERSION} /usr/src/php/ext/redis\
    && docker-php-ext-install -j $(nproc) redis

#------------------------------------------------------
# install gd extension
RUN apk add libpng-dev\
    && docker-php-ext-install gd

#------------------------------------------------------
# install msgpack for yar
ENV MSGPACK_VERSION 2.0.2

RUN curl -L -o ${PWD}/msgpack.tar.gz https://github.com/msgpack/msgpack-php/archive/msgpack-${MSGPACK_VERSION}.tar.gz \
    && tar xvf ${PWD}/msgpack.tar.gz\
    && rm ${PWD}/msgpack.tar.gz\
    && mv ${PWD}/msgpack-php-msgpack-${MSGPACK_VERSION} /usr/src/php/ext/msgpack\
    && docker-php-ext-install -j $(nproc) msgpack

#------------------------------------------------------
# install yar
ENV YAR_VERSION 2.0.4

RUN apk add curl-dev\
    && curl -L -o ${PWD}/yar.tar.gz https://github.com/laruence/yar/archive/yar-${YAR_VERSION}.tar.gz \
    && tar xvf ${PWD}/yar.tar.gz\
    && rm ${PWD}/yar.tar.gz\
    && mv ${PWD}/yar-yar-${YAR_VERSION} /usr/src/php/ext/yar\
    && docker-php-ext-install -j $(nproc) yar

# docker build -t xxx:xxx .
