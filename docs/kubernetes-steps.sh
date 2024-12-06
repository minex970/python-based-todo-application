# build image
docker build -t minex970/todo-app:v1 .
docker push minex970/todo-app:v1

# install cloudnative-pg for postgres database.
kubectl apply --server-side -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.23/releases/cnpg-1.23.1.yaml

# create separate namespace
kubectl create namespace todo-ns

# change the default namespace
kubectl config set-context --current --namespace=todo-ns
# verify it...
kubectl config view --minify | grep namespace:

# create the postgres cluster
kubectl apply -f postgresSecret.yaml
kubectl apply -f postgresConfigMap.yaml
kubectl apply -f postgresInitConfigMap.yaml
kubectl apply -f postgresCluster.yaml

# create the app deployment
kubectl apply -f appService.yaml
kubectl apply -f appDeployment.yaml

# to access the application
kubectl get nodes -o wide
curl http://<node-internal-ip>:<nodePort>

# troubleshooting...
kubectl exec -it postgresql-1 -- bash
PGPASSWORD='todo_password' psql -h 127.0.0.1 -U todo_user -d todo_database
SELECT * FROM goals;

# port forward application port
kubectl port-forward <app-pod-name> 8080:8080

# install nginx ingress controller on cluster
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml

# install nginx ingress controller on minikube
minikube addons enable ingress

# create the ingress resource
kubectl apply -f appIngress.yaml
