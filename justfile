traefik-build :
    helm template traefik apps/traefik/traefik --namespace traefik > infra/services/traefik.yaml

traefik-create: traefik-build
    kubectl create -f apps/traefik/namespace/namespace.yaml
    kubectl create -f infra/services/traefik.yaml
    kubectl create -f apps/traefik/others/certificate.yaml

traefik-apply : traefik-build
    kubectl apply -f apps/traefik/others/certificate.yaml
    kubectl apply -f infra/services/traefik.yaml

traefik-delete:
    kubectl delete -f apps/cert-manager/namespace/namespace.yaml
    kubectl delete -f apps/traefik/others/certificate.yaml
    kubectl delete -f infra/services/traefik.yaml

cert-manager-build :
    helm template cert-manager apps/cert-manager/cert-manager --namespace cert-manager > infra/services/cert-manager.yaml

cert-manager-create : cert-manager-build
    kubectl create -f apps/cert-manager/namespace/namespace.yaml
    kubectl create -f infra/services/cert-manager.yaml
    kubectl create -f apps/cert-manager/others/clusterissuer.yaml
    kubectl create -f apps/cert-manager/others/issuer-secret.yaml

cert-manager-apply : cert-manager-build
    kubectl apply -f infra/services/cert-manager.yaml
    kubectl apply -f apps/cert-manager/others/clusterissuer.yaml
    kubectl apply -f apps/cert-manager/others/issuer-secret.yaml

cert-manager-delete :
    kubectl delete -f apps/cert-manager/namespace/namespace.yaml
    kubectl delete -f infra/services/cert-manager.yaml
    kubectl delete -f apps/cert-manager/others/clusterissuer.yaml
    kubectl delete -f apps/cert-manager/others/issuer-secret.yaml

cnpg-build :
    helm template cnpg apps/cnpg/database --namespace database >> infra/services/cnpg.yaml
    helm template cnpg apps/cnpg/cnpg --namespace cnpg-system >> infra/services/cnpg.yaml

cnpg-create : cnpg-build
    kubectl create -f apps/cnpg/namespace/namespace.yaml
    kubectl create -f infra/services/cnpg.yaml

cnpg-apply : cnpg-build
    kubectl apply -f infra/services/cnpg.yaml --server-side

cnpg-delete :
    kubectl delete -f apps/cnpg/namespace/namespace.yaml
    kubectl delete -f infra/services/cnpg.yaml
    kubectl create -f infra/services/route.yaml

cluster:
    omnictl cluster template sync --file infra/cluster-template.yaml
