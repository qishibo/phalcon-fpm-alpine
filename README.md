# Phalcon fpm environment running in docker with alpine

> Based on image php:7.2-fpm-alpine3.7, total size is only 290MB


- PHP version 7.2.3
- Alpine version 3.7
- Phalcon version 3.3.1


## Usage

```bash
# pull image
docker pull qii404/phalcon-docker-fpm

# vi docker-compose.yml, change your code path to volumn. By default there is only a inedx.php in /var/www/html
/path-to-yout-code:/var/www/html

# start the container, docker-compose must be installed
docker-compose up

# view localhost:8088, you will see phpinfo
```

![phpinfo](http://7xsudm.com1.z0.glb.clouddn.com/%E6%B7%B1%E5%BA%A6%E6%88%AA%E5%9B%BE_%E9%80%89%E6%8B%A9%E5%8C%BA%E5%9F%9F_20180309174642.png)


Build php extensions

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
