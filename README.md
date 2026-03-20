# APISIX Cluster

Local Apache APISIX API Gateway running on Kubernetes (Kind) via Docker.

## Quick Start

```bash
./setup.sh          # create cluster and install everything
./setup.sh delete   # destroy the cluster
```

## Endpoints

| Service       | URL                    | Credentials     |
|---------------|------------------------|-----------------|
| Gateway HTTP  | http://localhost:80    | —               |
| Gateway HTTPS | https://localhost:443  | —               |
| Admin API     | http://localhost:9180  | —               |
| Dashboard     | http://localhost:9000  | admin / admin   |

## Prerequisites

- Docker
- WSL2 (if on Windows)

All other tools (`kind`, `kubectl`, `helm`) are installed automatically into `./bin/`.

## Documentation

- [Concepts — Kubernetes vs Docker](docs/concepts.md)
  - Pod, Node, Control Plane, Cluster, Namespace, Service, Deployment
  - Side-by-side comparison with Docker equivalents
- [Tools](docs/tools.md)
  - [Kind](docs/tools.md#kind) — Kubernetes in Docker
  - [kubectl](docs/tools.md#kubectl) — Kubernetes CLI
  - [Helm](docs/tools.md#helm) — Package manager for Kubernetes
- [Basic Commands](docs/commands.md)
  - [Cluster management](docs/commands.md#cluster-management)
  - [Inspect resources](docs/commands.md#inspect-resources)
  - [Debug](docs/commands.md#debug)
  - [Restart / Scale](docs/commands.md#restart--scale)
- [Configuration Flow](docs/configuration-flow.md)
  - [Step 1 — Cluster creation](docs/configuration-flow.md#step-1--cluster-creation-kind-clusteryaml)
  - [Step 2 — Install APISIX with Helm](docs/configuration-flow.md#step-2--install-apisix-with-helm)
  - [Step 3 — Expose services](docs/configuration-flow.md#step-3--expose-services-servicesyaml)
  - [Execution order](docs/configuration-flow.md#execution-order-in-setupsh)
- [Helm Values](docs/helm-values.md)
  - What is `values.yaml` and how Helm reads it
  - How to see all available options
- [Network Flow](docs/network-flow.md)
  - Complete path from browser to pod
  - The 3 layers: Kind mapping → NodePort → Pod
- [Troubleshooting](docs/troubleshooting.md)
  - WSL2 inotify fix
  - Pods stuck in Pending/CrashLoopBackOff
  - Port not accessible
  - Worker node fails to join
  - Helm CRD too large

## Project Files

| File                | Role                                                          |
|---------------------|---------------------------------------------------------------|
| `kind-cluster.yaml` | Defines the Kind cluster and maps container ports to localhost |
| `values.yaml`       | Helm overrides for APISIX (admin credentials)                 |
| `services.yaml`     | NodePort services that expose pods outside the cluster        |
| `namespace.yaml`    | Namespace definition for APISIX                               |
| `setup.sh`          | Orchestrates everything — installs tools, creates cluster, deploys APISIX |
| `docs/`             | Documentation                                                 |
