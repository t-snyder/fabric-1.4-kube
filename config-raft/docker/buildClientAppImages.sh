eval $(minikube docker-env)
docker build -f DockerFile-ClientApp -t library/client-app-green-airline:0.1 .
