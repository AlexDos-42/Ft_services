FROM alpine:3.12.0

RUN apk update
RUN apk add wget nginx
RUN mkdir /www
RUN apk add nginx openrc supervisor
RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
COPY srcs/instal.sh /instal.sh
RUN sh /instal.sh 
RUN mkdir -p /var/www/wordpress
COPY srcs/tmp-wp-config.php /www/wordpress/wp-config.php
COPY srcs/wordpress.sh /wordpress.sh
COPY srcs/03/* /www/wordpress/wp-content/uploads/2020/03/
COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 5050 

CMD ["sh", "/wordpress.sh"]
