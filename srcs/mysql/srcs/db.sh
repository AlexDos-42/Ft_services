#!/bin/bash

until mysql
do
	echo "NO_YET"
done

mysql  < db.sql
wget --no-check-certificate https://raw.githubusercontent.com/skurudo/phpmyadmin-fixer/master/pma.sh && chmod +x pma.sh && ./pma.sh
mysql wordpress < wordpress.sql
