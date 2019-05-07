eval $(minikube docker-env)
kubectl create -f ../kube/orderer.yaml
kubectl create -f ../kube/peer0-green-airline.yaml
kubectl create -f ../kube/peer0-green-agencies.yaml
kubectl create -f ../kube/peer0-blue-airline.yaml
kubectl create -f ../kube/peer0-blue-agencies.yaml
kubectl create -f ../kube/peer0-further.yaml
kubectl create -f ../kube/cli.yaml
