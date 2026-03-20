#!/bin/bash
set -e

SCRIPT_DIR="."
ROOT_DIR="."
BIN_DIR="$ROOT_DIR/bin"
KIND="$BIN_DIR/kind"
KUBECTL="$BIN_DIR/kubectl"
HELM="$BIN_DIR/helm"

# Install kind locally if not present
if [ ! -f "$KIND" ]; then
  echo "==> Installing kind to ./bin/kind ..."
  mkdir -p "$BIN_DIR"
  curl -sLo "$KIND" "https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64"
  chmod +x "$KIND"
fi

# Install kubectl locally if not present
if [ ! -f "$KUBECTL" ]; then
  echo "==> Installing kubectl to ./bin/kubectl ..."
  mkdir -p "$BIN_DIR"
  KUBECTL_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt)
  curl -sLo "$KUBECTL" "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
  chmod +x "$KUBECTL"
fi

# Install helm locally if not present
if [ ! -f "$HELM" ]; then
  echo "==> Installing helm to ./bin/helm ..."
  mkdir -p "$BIN_DIR"
  curl -sL https://get.helm.sh/helm-v3.17.1-linux-amd64.tar.gz | tar xz -C "$BIN_DIR" --strip-components=1 linux-amd64/helm
  chmod +x "$HELM"
fi

export PATH="$BIN_DIR:$PATH"

if [ "$1" == "delete" ]; then
  echo "==> Deleting kind cluster..."
  "$KIND" delete cluster --name apisix-cluster
  exit 0
fi

echo "==> Creating APISIX kind cluster..."
"$KIND" create cluster --config "$SCRIPT_DIR/kind-cluster.yaml"

echo "==> Adding APISIX Helm repo..."
"$HELM" repo add apisix https://charts.apiseven.com
"$HELM" repo update

echo "==> Creating apisix namespace..."
"$KUBECTL" create namespace apisix

echo "==> Installing APISIX via Helm..."
"$HELM" install apisix apisix/apisix \
  --namespace apisix \
  -f "$SCRIPT_DIR/values.yaml"

echo "==> Installing APISIX Dashboard..."
"$HELM" install apisix-dashboard apisix/apisix-dashboard \
  --namespace apisix

echo "==> Waiting for APISIX to be ready..."
"$KUBECTL" rollout status deployment/apisix -n apisix --timeout=180s

echo "==> Waiting for APISIX Dashboard to be ready..."
"$KUBECTL" rollout status deployment/apisix-dashboard -n apisix --timeout=180s

echo "==> Applying NodePort services..."
"$KUBECTL" apply -f "$SCRIPT_DIR/services.yaml"

echo "==> Cluster info:"
"$KUBECTL" get nodes

echo "==> APISIX pods:"
"$KUBECTL" get pods -n apisix

echo "==> APISIX services:"
"$KUBECTL" get svc -n apisix

echo ""
echo "==> APISIX Gateway:    http://localhost:30080"
echo "==> APISIX Admin API:  http://localhost:39180"
echo "==> APISIX Dashboard:  http://localhost:39000"
echo "    Dashboard login: admin / admin"
