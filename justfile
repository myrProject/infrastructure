namespaces:
    kubectl create namespace traefik
    kubectl create namespace cert-manager

traefik :
    helm template traefik apps/traefik/traefik --namespace traefik > infra/services/traefik.yaml

cert-manager-build :
    cat apps/cert-manager/namespace/namespace.yaml >> infra/services/cert-manager.yaml
    helm template cert-manager apps/cert-manager/cert-manager --namespace cert-manager > infra/services/cert-manager.yaml
    cat apps/cert-manager/others/clusterissuer.yaml >> infra/services/cert-manager.yaml
    cat apps/cert-manager/others/issuer-secret.yaml >> infra/services/cert-manager.yaml

cert-manager-deploy : cert-manager-build
    kubectl create -f infra/services/cert-manager.yaml
cert-manager-delete :
    kubectl delete -f infra/services/cert-manager.yaml


cluster:
    omnictl cluster template sync --file infra/cluster-template.yaml
