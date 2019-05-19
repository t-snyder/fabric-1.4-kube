#
kubectl create configmap      green-airline-config --from-file=../clientConfig/green-airline/org-context.properties -o yaml --dry-run | kubectl replace -f -
kubectl create secret generic green-airline-secret --from-file=../clientConfig/green-airline/config-client.json -o yaml --dry-run | kubectl replace -f -