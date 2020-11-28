FROM alpine
MAINTAINER Alex Dos Santos 

EXPOSE 80 443 22

RUN apk update && apk upgrade
RUN apk add openrc nginx 
RUN apk add openssh
RUN apk add openssl

RUN rm -rf /var/cache/apk/*
RUN rm /etc/nginx/conf.d/default.conf
COPY /srcs/nginx.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/nginx.conf
COPY /srcs/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add sshd

RUN adduser -D user
RUN echo "user:password" | chpasswd
RUN ssh-keygen -A
RUN mkdir -p /etc/nginx/ssl
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

RUN mkdir /www
COPY /srcs/tmp-index.html /www/index.html
COPY /srcs/img/* /www/
COPY /srcs/JQuery /www/JQuery
COPY /srcs/bootstrap /www/bootstrap

COPY ./srcs/docker.sh /docker.sh
RUN chmod 777 /docker.sh

ENTRYPOINT ["sh", "/docker.sh"]
