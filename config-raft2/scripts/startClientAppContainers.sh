eval $(minikube docker-env)
kubectl create -f ../kube/client-app-green-airline.yaml
#kubectl create -f sdk-org2.yaml
#kubectl create -f sdk-org3.yaml
#kubectl create -f sdk-org4.yaml