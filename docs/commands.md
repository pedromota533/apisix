# Basic Commands

## Cluster management

```bash
./bin/kind get clusters                                # list all Kind clusters
./bin/kubectl config get-contexts                      # list all kubectl contexts
./bin/kubectl config use-context kind-apisix-cluster   # switch context
```

## Inspect resources

```bash
./bin/kubectl get pods -n apisix               # list pods
./bin/kubectl get svc -n apisix                # list services
./bin/kubectl get deployments -n apisix        # list deployments
./bin/kubectl get all -n apisix                # list everything
./bin/kubectl get namespaces                   # list namespaces
```

## Debug

```bash
./bin/kubectl describe pod <pod-name> -n apisix    # detailed pod info
./bin/kubectl logs <pod-name> -n apisix            # pod logs
./bin/kubectl exec -it <pod-name> -n apisix -- sh  # shell into a pod
./bin/kubectl get events -n apisix                 # recent events
```

## Restart / Scale

```bash
./bin/kubectl rollout restart deployment/apisix -n apisix    # restart pods
./bin/kubectl scale deployment/apisix --replicas=3 -n apisix # scale up
```

## Apply changes

```bash
./bin/kubectl apply -f services.yaml           # apply a manifest
./bin/kubectl delete -f services.yaml          # remove resources from a manifest
```
