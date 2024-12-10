# Python-based Todo Application

## Application image:
![image](https://github.com/user-attachments/assets/bbc2b989-e468-4e01-aa19-c4061a204126)

## Architecture Diagram:
```mermaid
graph TD;
  client([Client]) -...-> ingress[Ingress controller];
  ingress[Ingress controller] -...-> n-ingress[Ingress resources];
  cert-manager[Cert-Manager] -...-> cert-resource[Issuer and certificate];
  n-ingress --> path1["/"] --> service1[app-svc:80];
  n-ingress --> path2["/health"] -->service1[app-svc:80];
  App -...-> service2[pg-svc:5432]

  subgraph Cluster
  ingress
  cert-manager

  subgraph Namespace
  n-ingress;
  cert-resource;
  cert-resource -...-> n-ingress;
  service1 --> pod1[app1-pod];
  service1 --> pod2[app1-pod];
  path1
  path2

  subgraph App
  pod1
  pod2
  end
  subgraph Config-map
  postgres-config
  postgres-init-config
  end
  subgraph Secret
  postgres-secret
  end

  service2[pg-svc:5432] --> pod3[postgresql-1];
  service2[pg-svc:5432] --> pod4[postgresql-2];
  service2[pg-svc:5432] --> pod5[postgresql-3];

  subgraph Database
  pod3
  pod4
  pod5

  end
  end
  end

  classDef plain fill:#ddd,stroke:#fff,stroke-width:4px,color:#000,font-size:40px;
  classDef k8s fill:#326ce5,stroke:#fff,stroke-width:4px,color:#fff,font-size:26px;
  classDef cluster fill:#fff,stroke:#bbb,stroke-width:4px,color:#326ce5,font-size:26px;
  classDef outer fill:#d97706,stroke:#b86004,stroke-width:4px,color:#fff,font-size:26px;
  classDef path fill:#28a745,stroke:#155724,stroke-width:4px,color:#fff,font-size:24px;
  classDef arrowColor stroke:#dcdcdc,stroke-width:6px;

  class n-ingress,postgres-secret,postgres-config,postgres-init-config,cert-resource,service1,service2,pod1,pod2,pod3,pod4,pod5 k8s;
  class client plain;
  class Cluster,Namespace,App,Config-map,Secret,Database cluster;
  class ingress,cert-manager outer;
  class path1,path2 path;
  linkStyle default stroke:#dcdcdc,stroke-width:6px;
```

## Documentation/Blogs:

1. Orchestration using 
[Docker-compose](https://minex.hashnode.dev/simple-docker-compose-deployment-for-python-based-todo-applications)

    Refer to the docs/docker-steps.sh and docs/docker-compose-steps.sh for better understanding.

    ```
    todo-application
    ├── app
    │   ├── app.py
    │   ├── Dockerfile
    │   ├── .dockerignore
    │   ├── requirements.txt
    │   └── templates
    │       └── index.html
    ├── docker-compose.yml
    ├── docs
    │   ├── docker-compose-steps.sh
    │   └── docker-steps.sh
    ├── .env.sample
    ├── init.sql
    └── README.md
    ```

    ```
    git clone --branch docker-compose https://github.com/minex970/python-based-todo-application.git
    ```

2. Orchestration using [kubernetes](https://minex.hashnode.dev/how-to-deploy-todo-apps-with-kubernetes-a-step-by-step-guide)

    Refer to the docs/kubernetes-steps.sh if needed.

    ```
    k8s-manifests/
    ├── app
    │   ├── appDeployment.yaml
    │   └── appService.yaml
    └── database
        ├── postgresCluster.yaml
        ├── postgresConfigMap.yaml
        ├── postgresInitConfigMap.yaml
        └── postgresSecret.yaml
    ```

    ```
    git clone --branch k8s-base https://github.com/minex970/python-based-todo-application.git
    ```

3. Auto-scaling: [HPA in kubernetes](https://minex.hashnode.dev/how-to-auto-scale-todo-apps-on-kubernetes-for-better-performance)

    Refer to the tests/steps.sh if needed.

    ```
    k8s-manifests/
    └── auto-scaling
        └── horizontalPodAutoScaler.yaml

    tests/
    ├── load-testing.js
    └── steps.sh
    ```

    ```
    git clone --branch k8s-autoscaling https://github.com/minex970/python-based-todo-application.git
    ```

4. Application with [Ingress with SSL/TLS](https://minex.hashnode.dev/securing-todo-apps-implement-kubernetes-ingress-with-ssltls)

    Refer to the docs for steps.
    ```
    k8s-manifests/
    ├── cert-manager
    │   ├── letsencryptCertificate.yaml
    │   ├── letsencryptClusterIssuer.yaml
    │   ├── selfsignedCertificate.yaml
    │   └── selfsignedClusterIssuer.yaml
    └── route
        └── appIngress.yaml
    ```

    ```
    git clone --branch k8s-ingress-ssl https://github.com/minex970/python-based-todo-application.git
    ```
