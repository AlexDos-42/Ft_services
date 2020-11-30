FROM	alpine

RUN		apk update
RUN		apk add openrc \
		influxdb

EXPOSE	8086

CMD		[ "influxd" ]