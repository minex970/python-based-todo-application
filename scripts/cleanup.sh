#!/bin/bash

cd ../k8s-manifests/

# delete all the certificate and issuers
kubectl delete -f route/appIngress.yaml

kubectl delete -f cert-manager/letsencryptClusterIssuer.yaml
kubectl delete -f cert-manager/letsencryptCertificate.yaml

kubectl delete -f cert-manager/selfsignedClusterIssuer.yaml
kubectl delete -f cert-manager/selfsignedCertificate.yaml

kubectl delete secret todo-letsencrypt-tls
kubectl delete secret todo-selfsigned-tls

# delete hpa
kubectl delete -f auto-scaling/horizontalPodAutoScaler.yaml

# delete deployment
kubectl delete -f app/appDeployment.yaml
kubectl delete -f app/appService.yaml

# delete database
kubectl delete -f database/postgresSecret.yaml
kubectl delete -f database/postgresConfigMap.yaml
kubectl delete -f database/postgresInitConfigMap.yaml
kubectl delete -f database/postgresCluster.yaml

# list all in namespace
kubectl get all -n todo-ns

# delete namespace
kubectl delete ns todo-ns
