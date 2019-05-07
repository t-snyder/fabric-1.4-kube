eval $(minikube docker-env)
/bin/bash deleteClientAppContainers.sh

cd ../docker
/bin/bash buildClientAppImages.sh

cd ../scripts
/bin/bash startClientAppContainers.sh
