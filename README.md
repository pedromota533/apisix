# APISIX Cluster

Apache APISIX API Gateway on Kubernetes, deployed via ArgoCD.

## Deployment

Apply the ArgoCD application manifests:

```bash
kubectl apply -f namespace.yaml
kubectl apply -f argocd-application.yaml
kubectl apply -f services.yaml
```

ArgoCD will automatically sync and deploy APISIX and the Dashboard from the Helm charts.

## Endpoints

| Service       | URL                       | Credentials     |
|---------------|---------------------------|-----------------|
| Gateway HTTP  | http://localhost:30080     | —               |
| Gateway HTTPS | https://localhost:30443    | —               |
| Admin API     | http://localhost:39180     | —               |
| Dashboard     | http://localhost:39000     | admin / admin   |

## Port Mapping

| Original Port | Exposed Port | Service         |
|---------------|-------------|-----------------|
| 80            | 30080       | Gateway HTTP    |
| 443           | 30443       | Gateway HTTPS   |
| 9180          | 39180       | Admin API       |
| 9000          | 39000       | Dashboard       |

## Prerequisites

- Kubernetes cluster
- ArgoCD installed on the cluster
- `kubectl` configured

## Project Files

| File                     | Role                                                     |
|--------------------------|----------------------------------------------------------|
| `argocd-application.yaml`| ArgoCD Application manifests for APISIX and Dashboard    |
| `kind-cluster.yaml`      | Kind cluster config with port mappings                   |
| `values.yaml`            | Helm overrides for APISIX (admin credentials)            |
| `services.yaml`          | NodePort services that expose pods outside the cluster   |
| `namespace.yaml`         | Namespace definition for APISIX                          |
| `docs/`                  | Documentation                                            |
