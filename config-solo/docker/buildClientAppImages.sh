eval $(minikube docker-env)
docker build -f DockerFile-ClientApp-GreenAirline -t library/client-app-green-airline:0.1 .
#docker build -f Sdk-Org2-Dockerfile -t library/sdk-org2:0.1 .
#docker build -f Sdk-Org3-Dockerfile -t library/sdk-org3:0.1 .
#docker build -f Sdk-Org4-Dockerfile -t library/sdk-org4:0.1 .