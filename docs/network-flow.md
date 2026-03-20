# Network Flow

## Complete path from browser to each service

```
Browser                Kind Container            Kubernetes              Pod
=======                ==============            ==========              ===

localhost:80    →  Docker:30080  →  NodePort  →  apisix:9080        (Gateway)
localhost:443   →  Docker:30443  →  NodePort  →  apisix:9443        (Gateway TLS)
localhost:9180  →  Docker:30180  →  NodePort  →  apisix:9180        (Admin API)
localhost:9000  →  Docker:30900  →  NodePort  →  dashboard:9000     (Dashboard)
```

## Internal (not exposed)

```
apisix  →  apisix-etcd:2379    (config store, cluster-internal only)
```

## How each layer works

### Layer 1 — Kind port mapping (`kind-cluster.yaml`)

Maps a port on your machine (localhost) to a port on the Docker container:

```
localhost:80 → Docker container:30080
```

Equivalent to `docker run -p 80:30080`.

### Layer 2 — NodePort service (`services.yaml`)

Maps a port on the Docker container (node) to a port on the pod:

```
Docker container:30080 → Pod:9080
```

### Layer 3 — Pod

The actual APISIX process listening on its port (9080, 9443, 9180, 9000).

## Why three layers?

Kubernetes was designed for cloud environments where you don't control the host machine directly. NodePort + port mappings are the workaround for local development with Kind, bridging the gap between your browser and the pods running inside a Docker container pretending to be a Kubernetes node.
