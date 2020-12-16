# Ft_services [![jaeskim's 42Project Score](https://badge42.herokuapp.com/api/project/alesanto/ft_services)](https://github.com/JaeSeoKim/badge42)

This project consist to clusturing an docker-compose application and deploy it with Kubernetes. 

![screen](https://github.com/AlexDos-42/Ft_services/blob/main/img_readme/Capture%20d%E2%80%99e%CC%81cran%202020-11-28%20a%CC%80%2018.50.24.png)

## Containers

- Nginx
- FTPs
- Grafana
- InfluxDB
- Wordpress
- Mysql
- phpMyAdmin

## Instructions

This is the list of commands:

	sh setup.sh instal		Instal minikube
	sh setup.sh start		Start minikube
	sh setup.sh services		Build services
	sh setup.sh clear		Stop and delete services

When the project is running, you can use:

	minikube dashboard
	minikube stop
	minikube delete
	kubectl get service
	kubectl get deployment
	kubectl get pods

If ft_services is running, go on link bellow:

	http://192.168.49.20

To test the ftps server:

	ftp 192.168.49.20 21
		-> alesanto - password
	put name-of-the-file
	if error 500: use command pass
	
### Dashboard Kubernetes

![screen](https://github.com/AlexDos-42/Ft_services/blob/main/img_readme/Capture%20d%E2%80%99e%CC%81cran%202020-11-28%20a%CC%80%2018.49.47.png)

### Dashboards Grafana

![screen](https://github.com/AlexDos-42/Ft_services/blob/main/img_readme/Capture%20d%E2%80%99e%CC%81cran%202020-11-28%20a%CC%80%2018.56.48.png)
