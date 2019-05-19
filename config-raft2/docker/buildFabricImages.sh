eval $(minikube docker-env)
docker build -f DockerFile-CA-Simple -t library/fabric-ca:1.4.1 .
docker build -f Peer0-Green-Airline-Dockerfile -t library/peer0-green-airline:1.4.1 .
docker build -f Peer0-Green-Agencies-Dockerfile -t library/peer0-green-agencies:1.4.1 .
docker build -f Peer0-Blue-Airline-Dockerfile -t library/peer0-blue-airline:1.4.1 .
docker build -f Peer0-Blue-Agencies-Dockerfile -t library/peer0-blue-agencies:1.4.1 .
docker build -f Peer0-Further-Dockerfile -t library/peer0-further:1.4.1 .
docker build -f CLI-Dockerfile -t library/cli-peer:1.4.1 .
docker build -f Orderer1-Dockerfile -t library/orderer1:1.4.1 .
docker build -f Orderer2-Dockerfile -t library/orderer2:1.4.1 .
docker build -f Orderer3-Dockerfile -t library/orderer3:1.4.1 .
