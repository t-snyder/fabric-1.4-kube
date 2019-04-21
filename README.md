# fabric-1.4-kube
Build kubernetes dev environment for Fabric 1.4

See the docs folder for a better formatting.

1 Project Purpose

The purpose of this project is:

    1) Provide a local dev environment for the Hyperledger Fabric using a Kubernetes Minikube for running the various containers.
    2) Illustrate the process necessary for creating a Fabric development environment.
    3) Provide a generic wrapper functionality around the Fabric Java SDK that manages both a happy path as well as error handling for Fabric transactions.
    4) Provide a starting point for Fabric smart contract development and integration.
    

This document assumes the reader has an understanding of the Hyperledger Fabric architecture and has read the Fabric documents which can be found at http://hyperledger-fabric.readthedocs.io/en/latest/ . The configuration information provided here is more an extension of this information targeting how the various process interdependencies work at a physical level. In addition the sdk wrapper implementation discussion provides an understanding of how to interact with the Java Fabric SDK in both happy path and error paths.

Again the purpose of this project is to provide a local dev environment for Fabric development.

Current limitations for the project include:
    • Uses a solo Orderer and does not use the Kafka/Zookeeper Orderer
    • Does not use TLS communication
    • Only 1 Peer per organization

The various steps and command files provided within this project are designed for illustrative purposes and not necessarily the most efficient/generic way.

2 Getting Started
This section provides instructions for running the containers and project without modifying the existing configuration. As a result of using the preconfigution of Organizations and Users, the crypto material has already been generated and the configuration will only need to be updated for project path considerations.

2.1 Installing Kubernetes and Minikube
Instructions for installing Minikube on your local machine are beyond the scope of this document. Multiple resources can be found online for this. A good place to start is 
https://kubernetes.io/docs/getting-started-guides/minikube/  

The development and testing for this project has been done on a Ubuntu 16.04 laptop with an i7-7700K CPU @ 4.20GHz, 8 cores and 64GB Ram with a 1Gb internet connection. Kvm2 was used for the vm driver.

2.2 Starting a Fresh Minikube
The following command allocates 4 cpu cores and 12G memory to the minikube vm. This can be changed per machine needs. It also uses linux kvm2 as the vm. From within a terminal (We will call it the minikube terminal):

minikube start --cpus 4 --memory 12288 --vm-driver kvm2 \
–-extra-config=apiserver.authorization-mode=RBAC --disk-size 100g \
--docker-opt "dns=10.96.0.10 --dns=192.168.0.1 --dns-search \
default.svc.cluster.local --dns-search \
svc.cluster.local --dns-opt ndots:2 --dns-opt \
timeout:2 --dns-opt attempts:2 "

Values you may want to modify:
1) Number of CPUS – 1 is minimum, suggest at least 2;
2) Memory – at least 4 GB
3) VM Driver – set to the vm you are using
3) Disk Size – minimum 50 GB
5) Docker DNS - The dns 10.96.0.10 represents the cluster ip address of the kube-dns service. This is found via minikube dashboard → kube system namespace → services → kube-dns	


2.3 Build the Docker images
    1) Reuse the Command Terminal
    2) go to the config/docker directory within the project
    3) /bin/bash buildFabricImages.sh
    4) In the minikube terminal check to see that the new images are there
        1) minikube ssh
        2) docker images
        3) the output of the docker images should show the images
       
2.4 Start Fabric docker containers
    1) Using the command terminal
        1) cd ../kube
        2) /bin/bash startFabricContainers.sh
    2) To verify the services and pods open up a web browser to kubernetes with the following command. Note – This may take a few minutes to completely start.
        1) minikube dashboard


2.5 Joining channels and installing chaincodecd
    1) Using the minikube terminal
        1) docker ps -a (lists all of the containers)
    2) Find the container starting with k8s_cli-container_fabric-cli
        1) copy the container id for the cli container
    3) Log into the container via
        1) docker exec -it <container id> /bin/bash
    4) At directory /opt/gopath/src/github.com/hyperledger/fabric/peer – You should be there
        1) /bin/bash channel-join.sh
        2) /bin/bash install-chaincode.sh


2.6 Create the client-app configmap and secrets
    1) Go to the scripts directory
        1) /bin/bash createConfigAndSecrets.sh

2.7 Build the client-core project
    1) Run maven clean
    2) Run maven install – the install will copy to jar to the builder project


2.8 Build the Client App Images
    1) Reuse the Command Terminal
    2) go to the config/docker directory within the project
    3) /bin/bash buildClientAppImages.sh
    4) In the minikube terminal check to see that the new images are there
        1) minikube ssh
        2) docker images
        3) the output of the docker images should show the images

2.9 Starting the client-app service(s)
Note the container is currently set to not start the jar, this can be changed via the sdk-org1.yaml file. To start with though it is better to manually start it and be able to see the output.
    1) Using the command terminal
        1) cd ../scripts
        2) /bin/bash startClientAppContainers.sh
    2) Using the minikube terminal
        1) docker ps -a (lists the containers running)
    3) Find the container with sdk-org1 (should be at top of list)
        1) copy the container id
    4) Log into container via
        1) docker exec -it <container id> /bin/sh
    5) Inside container shell start the service
        1) /usr/bin/java -jar /usr/lib/clientapp.jar

2.10 Refreshing changes to the client application
    1) Inside container shell start the service
        1) Rebuild client app project (maven clean; maven install)
        2) /bin/bash refreshClientAppContainers.sh
