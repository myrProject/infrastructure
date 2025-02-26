traefik-build :
    helm template traefik apps/traefik/traefik --namespace traefik > infra/services/traefik.yaml

traefik-create:
    kubectl create -f apps/traefik/namespace/namespace.yaml
    kubectl create -f infra/services/traefik.yaml

traefik-delete:
    kubectl delete -f apps/cert-manager/namespace/namespace.yaml
    kubectl delete -f infra/services/traefik.yaml

cert-manager-build :
    helm template cert-manager apps/cert-manager/cert-manager --namespace cert-manager > infra/services/cert-manager.yaml

cert-manager-create : cert-manager-build
    kubectl create -f apps/cert-manager/namespace/namespace.yaml
    kubectl create -f infra/services/cert-manager.yaml
    kubectl create -f apps/cert-manager/others/clusterissuer.yaml
    kubectl create -f apps/cert-manager/others/issuer-secret.yaml

cert-manager-delete :
    kubectl delete -f apps/cert-manager/namespace/namespace.yaml
    kubectl delete -f infra/services/cert-manager.yaml
    kubectl delete -f apps/cert-manager/others/clusterissuer.yaml
    kubectl delete -f apps/cert-manager/others/issuer-secret.yaml


cluster:
    omnictl cluster template sync --file infra/cluster-template.yaml
