# APISIX Cluster

Apache APISIX API Gateway on Kubernetes, deployed via ArgoCD.

## Deployment

ArgoCD application manifest lives in `../argocd/apisix-app.yaml`.
ArgoCD reads this repo automatically and deploys APISIX and the Dashboard from the Helm charts.

## Endpoints

| Service       | URL                       | Credentials     |
|---------------|---------------------------|-----------------|
| Gateway HTTP  | http://localhost:30080     | —               |
| Gateway HTTPS | https://localhost:30443    | —               |
| Admin API     | http://localhost:30180     | —               |
| Dashboard     | http://localhost:30000     | admin / admin   |

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
| `values.yaml`            | Helm overrides for APISIX (admin credentials)            |
| `services.yaml`          | NodePort services that expose pods outside the cluster   |
| `namespace.yaml`         | Namespace definition for APISIX                          |
| `docs/`                  | Documentation                                            |
