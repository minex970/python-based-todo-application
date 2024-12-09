#!/bin/bash

cd ../k8s-manifests/

# Prompt user for deletion choice
echo "Choose an option:"
echo "1. Delete all resources"
echo "2. Delete only certificates and issuers"
read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
  echo "Deleting all resources..."

  # Delete certificates and issuers
  kubectl delete -f route/appIngress.yaml

  kubectl delete -f cert-manager/letsencryptClusterIssuer.yaml
  kubectl delete -f cert-manager/letsencryptCertificate.yaml

  kubectl delete -f cert-manager/selfsignedClusterIssuer.yaml
  kubectl delete -f cert-manager/selfsignedCertificate.yaml

  kubectl delete secret todo-letsencrypt-tls
  kubectl delete secret todo-selfsigned-tls

  # Delete HPA
  kubectl delete -f auto-scaling/horizontalPodAutoScaler.yaml

  # Delete deployment
  kubectl delete -f app/appDeployment.yaml
  kubectl delete -f app/appService.yaml

  # Delete database
  kubectl delete -f database/postgresSecret.yaml
  kubectl delete -f database/postgresConfigMap.yaml
  kubectl delete -f database/postgresInitConfigMap.yaml
  kubectl delete -f database/postgresCluster.yaml

  # List all resources in namespace
  kubectl get all -n todo-ns

  # Delete namespace
  kubectl delete ns todo-ns

elif [ "$choice" == "2" ]; then
  echo "Deleting only certificates and issuers..."

  # Delete certificates and issuers
  kubectl delete -f route/appIngress.yaml

  kubectl delete -f cert-manager/letsencryptClusterIssuer.yaml
  kubectl delete -f cert-manager/letsencryptCertificate.yaml

  kubectl delete -f cert-manager/selfsignedClusterIssuer.yaml
  kubectl delete -f cert-manager/selfsignedCertificate.yaml
  kubectl get all -n todo-ns
  kubectl delete secret todo-letsencrypt-tls
  kubectl delete secret todo-selfsigned-tls

else
  echo "Invalid choice. Exiting."
  exit 1
fi
