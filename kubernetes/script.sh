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
