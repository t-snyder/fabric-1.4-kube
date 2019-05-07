eval $(minikube docker-env)

docker build -f DockerFile-CA-Simple -t library/fabric-ca-server:1.4 .
