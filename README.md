# Phalcon FPM Env Running In Docker Based On Apline

> Based on image php:7.2.5-fpm-alpine3.7, total size is only 95MB.


## Version

- PHP 7.2.5
- Alpine 3.7
- Phalcon 3.3.1
- Redis 3.1.2
- Memcached 3.0.3
- Msgpack 2.0.2

## Image

`docker pull qii404/phalcon-fpm-alpine`


## Usage

```bash
# clone code
git clone https://github.com/qishibo/phalcon-fpm-alpine.git
cd phalcon-fpm-alpine

# [optional] edit docker-compose.yml, volume your code path to /var/www/html
# By default there is only a index.php
# path-to-your-code:/var/www/html

# start the container, docker-compose is recommend
docker-compose up -d

# view localhost:8088, you will see phpinfo
```

![phpinfo](https://ws1.sinaimg.cn/large/71405cably1g25gv6xsf4j20qh0ph77y.jpg)
