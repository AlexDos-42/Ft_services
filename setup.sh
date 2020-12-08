if [ "$1" = "install" ]
then
	echo "\e[93m\tInstal minikube properly\e[0m"
 	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
 	sudo install minikube-linux-amd64 /usr/local/bin/minikube
	echo "\e[93mUse cmd : sudo usermod -aG docker $USER\e[0m"
	exit
fi


if [ "$1" = "clear" ]
then
	echo "\e[91m►   Delete containers\e[0m"
	docker system prune -a
	kubectl delete -f srcs > /dev/null
	exit
fi

if [ "$1" = "start" ] 
then
	echo "\e[93m►   Start minikube\e[0m"
	minikube start --memory 2000 --vm-driver=docker --bootstrapper=kubeadm
	minikube addons enable dashboard
	minikube addons enable metrics-server
	exit
fi

if [ "$1" = "services" ]
then
	eval $(minikube docker-env)

	echo "\e[93m►   Instal metallb.\e[0m"
	minikube addons enable metallb

	export MINI=$(minikube ip | grep -oE "\b([0-9]{1,3}\.){3}\b")20

	echo "\e[93m►   Replace IP in config-files.\e[0m"
	cp srcs/mysql/srcs/wordpress.sql.copy srcs/mysql/srcs/wordpress.sql
	sed -i "s/MYIP/$MINI/g" srcs/mysql/srcs/wordpress.sql
	cp srcs/nginx/srcs/index.html srcs/nginx/srcs/tmp-index.html
	sed -i "s/IP/$MINI/g" srcs/nginx/srcs/tmp-index.html

	echo "\e[93m►   Delete all services.\e[0m"
	kubectl delete deployments --all > /dev/null
	kubectl delete services --all > /dev/null

	kubectl apply -f srcs/metallb.yaml

	echo "\e[93m►   Build Pods.\e[0m"
	echo "\e[93mBuilding Nginx:\e[0m"
	docker build -t mynginx srcs/nginx/
	echo "\e[93mBuilding ftps:\e[0m"
	docker build -t myftps srcs/ftps/ 
	echo "\e[93mBuilding Grafana:\e[0m"
	docker build -t mygrafana srcs/grafana/
	echo "\e[93mBuilding mysql:\e[0m"
	docker build -t mymysql srcs/mysql/
	echo "\e[93mBuilding wordpress:\e[0m"
	docker build -t mywordpress srcs/wordpress/
	echo "\e[93mBuilding phpmyadmin:\e[0m"
	docker build -t myphpmyadmin srcs/phpmyadmin/
	echo "\e[93mBuilding influxdb:\e[0m"
	docker build -t myinfluxdb srcs/influxdb/
	echo "\e[93mBuilding telegraf:\e[0m"
	docker build -t mytelegraf srcs/telegraf/

	echo "\e[93m►   Deployment\e[0m"
	kubectl apply -f srcs/mynginx.yaml > /dev/null
	kubectl apply -f srcs/myftps.yaml > /dev/null
	kubectl apply -f srcs/mymysql.yaml > /dev/null
	kubectl apply -f srcs/myphpmyadmin.yaml > /dev/null
	kubectl apply -f srcs/mywordpress.yaml > /dev/null
	kubectl apply -f srcs/myinfluxdb.yaml > /dev/null
	kubectl apply -f srcs/mytelegraf.yaml > /dev/null
	kubectl apply -f srcs/mygrafana.yaml > /dev/null
	echo "\e[93m►   FT_Services is running\e[0m"
	echo "\e[94m\n►   Minicube ip: $MINI\e[0m"
	exit
fi

export MINI=$(minikube ip | grep -oE "\b([0-9]{1,3}\.){3}\b")20
echo "\e[93m►  --Welcome in FT_services a 42 Project--
_____________________________________________
This is the list of commands:
	sh ${0} instal		Install minikube
	sh ${0} start		Start minikube
	sh ${0} services		Build services
	sh ${0} clear		Stop and delete services

When the project is running, you can use:
	minikube dashboard
	minikube stop
	minikube delete
	kubectl get service
	kubectl get deployment
	kubectl get pods
	kubectl delete -n default pod name-of-the-pod
If ft_services is running, click on link bellow:
	http://$MINI
To test the ftps server:
	ftp 192.168.49.20 21		to acces ther server
		-> alesanto - password
	put name-of-the-file
	if error 500: use command pass
_____________________________________________\e[0m"

# kubectl exec -t nginx-75b7bfdb6b-p5vhv -i -t -- bash -il
# minikube service list
