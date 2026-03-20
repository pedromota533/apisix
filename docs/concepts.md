# Concepts — Kubernetes vs Docker

If you already know Docker, here's how Kubernetes concepts map to it:

| Kubernetes       | Docker Equivalent        | What it does                                                              |
|------------------|--------------------------|---------------------------------------------------------------------------|
| **Pod**          | Container                | The smallest unit that runs your application                              |
| **Node**         | Host machine             | The machine (physical or virtual) where containers run                    |
| **Control Plane**| Docker daemon (`dockerd`)| The "brain" — decides where to run what, monitors, and restarts on failure|
| **Cluster**      | Docker engine            | The full set — daemon + machines + all containers                         |
| **Namespace**    | —                        | Logical separation within a cluster (like folders for resources)          |
| **Service**      | `--publish` / `-p`       | Exposes a pod's port so other pods or the outside world can reach it      |
| **Deployment**   | `docker-compose` service | Declares the desired state (image, replicas) and keeps it running         |

---

## Pod

A pod is one or more containers running together. In most cases, one pod = one container. It's the smallest deployable unit in Kubernetes.

## Node

A node is a machine in the cluster. In our case, Kind simulates a node as a **Docker container**. So we have a Docker container pretending to be a machine running more containers inside it.

## Control Plane

The control plane manages the cluster. It decides which pods go on which nodes, monitors health, and restarts failed pods. In our single-node Kind setup, the control plane and the worker run on the same node.

## Namespace

A namespace is a way to group resources. Our APISIX resources live in the `apisix` namespace, keeping them isolated from system resources in `kube-system`.

## Service

A service exposes a pod's port to other pods or to the outside world. There are different types:

| Type        | Scope                  | Docker equivalent            |
|-------------|------------------------|------------------------------|
| ClusterIP   | Internal only          | Container-to-container link  |
| NodePort    | Exposed on the node    | `docker run -p 30080:9080`   |
| LoadBalancer| External load balancer | Not available in Kind        |

## Deployment

A deployment declares what should be running (image, replicas, config) and Kubernetes ensures it stays that way. If a pod crashes, the deployment automatically creates a new one.
