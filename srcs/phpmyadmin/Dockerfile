FROM alpine:3.12.0
MAINTAINER Alex Dos Santos <alesantostudent.42.fr>

RUN apk update
RUN apk upgrade
RUN apk add php7 php7-fpm php7-opcache
RUN apk add php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
RUN apk add nginx

COPY srcs/*.sh ./
RUN chmod 755 *.sh
RUN mkdir -p /www/phpmyadmin

RUN mkdir /var/run/nginx && \
	adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx
COPY srcs/nginx.conf /etc/nginx/nginx.conf

RUN sh /instalphp.sh

COPY srcs/phpmyadmin.inc.php /www/phpmyadmin/config.inc.php

EXPOSE 5000

RUN rm -rf /var/cache/apk/*
ENTRYPOINT ["sh", "/phpadmin.sh"]
