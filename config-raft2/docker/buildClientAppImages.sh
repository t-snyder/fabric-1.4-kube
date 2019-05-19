eval $(minikube docker-env)
docker build -f DockerFile-ClientApp-GreenAirline -t library/client-app-green-airline:0.1 .
