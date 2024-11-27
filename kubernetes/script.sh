#/bin/bash
kubectl create namespace redis --dry-run=client -o yaml > namespace.yml
kubectl create deployment redis --image=nginx --port=80 -n redis --dry-run=client -o yaml > deploy.yml
kubectl create svc clusterip redis --tcp=80 -n redis --dry-run=client -o yaml > service.yml
kubectl create ingress redis-ing -n redis --rule='mon-domaine/*=redis:80' --class=nginx --dry-run=client -o yaml > ingress.yml
kubectl create service externalname redis-svc-bridge -n argocd --external-name redis.redis.svc.cluster.local --tcp=80 --dry-run=client -o yaml > external-service.yml

# creation automatique du fichier kustomization.yaml
kustomize create --autodetect
# deploiement via kustomize les manifests de dev
kubectl create -k overlays/dev/

# créer un cluster Redis à l'aide de l'outil CLI redis-cli
kubectl exec -it -n redis deployments/dev-redis-creator -- redis-cli --cluster create $(kubectl get pods -n redis -o wide | grep redis-worker | awk '{print $6":6379"}' | tr '\n' ' ') --cluster-replicas 1

# Vérifiez que tous les nœuds Redis sont correctement configurés comme maîtres et répliques dans le cluster
kubectl exec -it -n redis deployments/dev-redis-creator -- redis-cli cluster nodes

# Vérification que le worker est bien configuré
kubectl exec -it -n redis statefulsets/dev-redis-workers  -- redis-cli ping