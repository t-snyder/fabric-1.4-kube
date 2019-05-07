eval $(minikube docker-env)
kubectl create      configmap green-airline-config --from-file=../clientConfig/green-airline/org-context.properties
kubectl create secret generic green-airline-secret --from-file=../clientConfig/green-airline/config-client.json