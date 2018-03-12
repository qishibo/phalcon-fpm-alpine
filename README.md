# Phalcon Fpm Env Running In Docker With Php7.2 Based On Apline

> Based on image php:7.2-fpm-alpine3.7, total size is only 290MB


## Version

- PHP version 7.2.3
- Alpine version 3.7
- Phalcon version 3.3.1


## Usage

```bash
# pull image
docker pull qii404/phalcon-docker-fpm

# [optional] edit docker-compose.yml, volume your code path to /var/www/html
# By default there is only a inedx.php if you not volume to docker
# /path-to-your-code:/var/www/html

# start the container, docker-compose must be installed
docker-compose up -d

# view localhost:8088, you will see phpinfo
```


## Builded Php Extensions

```
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
json
libxml
mbstring
memcached
msgpack
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_sqlite
phalcon
Phar
posix
readline
redis
Reflection
session
SimpleXML
sodium
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
yar
zlib
```

![phpinfo](http://7xsudm.com1.z0.glb.clouddn.com/%E6%B7%B1%E5%BA%A6%E6%88%AA%E5%9B%BE_%E9%80%89%E6%8B%A9%E5%8C%BA%E5%9F%9F_20180309174642.png)
