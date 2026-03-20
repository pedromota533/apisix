# Configuration Flow

Step-by-step of what `setup.sh` does and why.

---

## Step 1 — Cluster creation (`kind-cluster.yaml`)

```bash
kind create cluster --config kind-cluster.yaml
```

Kind reads `kind-cluster.yaml` and creates a Docker container acting as a Kubernetes node:

```yaml
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
name: apisix-cluster
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 30080    # inside the container
        hostPort: 80            # on your machine (localhost)
```

`extraPortMappings` is the equivalent of `docker run -p 80:30080`. It makes ports inside the Kind container accessible from your browser.

**After this step:** you have an empty Kubernetes cluster with port mappings ready.

---

## Step 2 — Install APISIX with Helm

```bash
helm repo add apisix https://charts.apiseven.com
helm install apisix apisix/apisix --namespace apisix -f values.yaml
helm install apisix-dashboard apisix/apisix-dashboard --namespace apisix
```

Helm downloads the APISIX chart and creates all the Kubernetes resources:

- **Deployment** `apisix` — creates the gateway pod
- **Deployment** `apisix-etcd` — creates the config store pod
- **Deployment** `apisix-dashboard` — creates the dashboard pod
- **Services** (ClusterIP) — internal networking between pods

The `-f values.yaml` overrides specific chart defaults (enables admin API, sets credentials).

**After this step:** APISIX is running inside the cluster but **not accessible from localhost** — all services are ClusterIP (internal only).

---

## Step 3 — Expose services (`services.yaml`)

```bash
kubectl apply -f services.yaml
```

Creates **NodePort** services that bridge internal pod ports to the Kind container ports:

```yaml
# Example: gateway service
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 9080    # APISIX gateway listens here
      nodePort: 30080     # exposed on the Kind container
```

The chain: `pod:9080` ← NodePort `30080` ← Kind mapping → `localhost:80`

**After this step:** everything is accessible from your browser.

---

## Execution order in `setup.sh`

```
1. Install tools (kind, kubectl, helm)     → ./bin/
2. Create Kind cluster                      → kind-cluster.yaml
3. Add Helm repo                            → charts.apiseven.com
4. Create namespace                         → apisix
5. Install APISIX via Helm                  → values.yaml
6. Install Dashboard via Helm
7. Wait for pods to be ready
8. Apply NodePort services                  → services.yaml
9. Print endpoints
```
