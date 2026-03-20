# Troubleshooting

## Cluster creation fails on WSL2

**Error:** `could not find a log line that matches "Reached target .*Multi-User System.*"`

**Cause:** insufficient inotify limits on WSL2.

**Fix:**

```bash
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl fs.inotify.max_user_instances=512
```

Make it persistent across WSL restarts:

```bash
echo -e "fs.inotify.max_user_watches=524288\nfs.inotify.max_user_instances=512" | sudo tee /etc/sysctl.d/kind.conf
```

---

## Pods stuck in Pending / CrashLoopBackOff

```bash
./bin/kubectl describe pod <pod-name> -n apisix   # check events at the bottom
./bin/kubectl logs <pod-name> -n apisix            # check application logs
```

Common causes:
- **Pending** — not enough resources or node not ready
- **CrashLoopBackOff** — the container starts and crashes repeatedly (check logs)

---

## Port not accessible from browser

1. Check the service exists: `./bin/kubectl get svc -n apisix`
2. Check the pod is running: `./bin/kubectl get pods -n apisix`
3. Test from WSL: `curl http://localhost:80`
4. Check Docker port mapping: `docker ps` (look for the port columns)

---

## Worker node fails to join

**Error:** `kubelet is not healthy after 4m0s`

**Cause:** resource constraints on WSL2 or Docker. Common when running multiple clusters.

**Fix:** use a single control-plane node (no workers). Remove `- role: worker` from `kind-cluster.yaml`.

---

## Helm CRD too large

**Error:** `metadata.annotations: Too long: may not be more than 262144 bytes`

**Fix:** use server-side apply:

```bash
./bin/kubectl apply --server-side -f <manifest>
```
