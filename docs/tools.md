# Tools

All tools are installed automatically into `./bin/` by `setup.sh`.

---

## Kind

**Kubernetes in Docker** — runs a full Kubernetes cluster inside Docker containers. Each "node" is a Docker container running `kindest/node` image with `kubelet`, `containerd`, and the Kubernetes control plane.

```bash
# Create a cluster
./bin/kind create cluster --config kind-cluster.yaml

# Delete a cluster
./bin/kind delete cluster --name apisix-cluster

# List clusters
./bin/kind get clusters
```

---

## kubectl

The Kubernetes CLI. Used to manage everything inside the cluster — pods, services, deployments, namespaces, etc.

```bash
# Cluster info
./bin/kubectl cluster-info
./bin/kubectl get nodes

# Pods
./bin/kubectl get pods -n apisix
./bin/kubectl describe pod <pod-name> -n apisix
./bin/kubectl logs <pod-name> -n apisix

# Services
./bin/kubectl get svc -n apisix

# Deployments
./bin/kubectl get deployments -n apisix

# All resources in a namespace
./bin/kubectl get all -n apisix
```

---

## Helm

A package manager for Kubernetes. A Helm **chart** is a pre-built set of Kubernetes manifests (deployments, services, configmaps, etc.) that you can install with a single command.

```bash
# Add a chart repository
./bin/helm repo add apisix https://charts.apiseven.com

# Search available charts
./bin/helm search repo apisix

# Install a chart
./bin/helm install apisix apisix/apisix --namespace apisix -f values.yaml

# List installed releases
./bin/helm list -n apisix

# Uninstall
./bin/helm uninstall apisix -n apisix

# See all configurable values of a chart
./bin/helm show values apisix/apisix
```
