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
    helm template cert-manager apps/monitoring/cert-manager --namespace cert-manager > infra/services/cert-manager.yaml

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
    helm template cnpg apps/opera/cluster --namespace database > infra/services/cnpg.yaml
    helm template cnpg apps/cnpg/operator --namespace cnpg-system >> infra/services/cnpg.yaml

cnpg-create : cnpg-build
    kubectl create -f apps/cnpg/namespace/namespace.yaml
    kubectl create -f infra/services/cnpg.yaml

cnpg-apply : cnpg-build
    kubectl apply -f infra/services/cnpg.yaml --server-side --force-conflicts

cnpg-delete :
    kubectl delete -f apps/cnpg/namespace/namespace.yaml
    kubectl delete -f infra/services/cnpg.yaml

vw-build :
    helm template cnpg apps/vaultwarden/vaultwarden --namespace vaultwarden > infra/services/vaultwarden.yaml

vw-create :
    kubectl create -f apps/vaultwarden/namespace/namespace.yaml
    kubectl create -f infra/services/vaultwarden.yaml

vw-apply :
    kubectl apply -f infra/services/vaultwarden.yaml

vw-delete :
    kubectl delete -f apps/vaultwarden/namespace/namespace.yaml
    kubectl delete -f infra/services/vaultwarden.yaml

kanidm-create:
    kubectl create -f apps/kanidm/namespace/namespace.yaml
    kubectl create -f apps/kanidm/others/certificate.yaml
    kubectl create -f infra/services/kanidm.yaml

kanidm-apply:
    kubectl apply -f infra/services/kanidm.yaml

kanidm-delete:
    kubectl delete -f infra/services/kanidm.yaml


vpn-build:
    helm template wireguard apps/wireguard/wireguard --namespace vpn > infra/services/wg.yaml

cluster:
    omnictl cluster template sync --file infra/cluster-template.yaml

kpg-build :
    helm template cnpg apps/vaultwarden/vaultwarden --namespace vaultwarden > infra/services/vaultwarden.yaml


mail-build:
    helm template stalwart-mail apps/stalwart-mail-helm/stalwart-mail --namespace mail> infra/services/stalwart-mail.yaml

mail-create: mail-build
    kubectl create -f infra/services/stalwart-mail.yaml

mail-apply: mail-build
    kubectl apply -f infra/services/stalwart-mail.yaml

mail-delete:
    kubectl delete -f infra/services/stalwart-mail.yaml

harbor-build:
    helm template harbor apps/harbor/harbor --namespace harbor > infra/services/harbor.yaml

harbor-create: harbor-build
    kubectl create -f infra/services/harbor.yaml

harbor-apply: harbor-build
    kubectl apply -f infra/services/harbor.yaml

harbor-delete:
    kubectl delete -f infra/services/harbor.yaml

matrix-build:
    helm template matrix apps/matrix/matrix --namespace matrix > infra/services/matrix.yaml

matrix-create: matrix-build
    kubectl create -f infra/services/matrix.yaml

matrix-delete:
    kubectl delete -f infra/services/matrix.yaml


wiki-build:
    helm template matrix apps/wiki/wiki --namespace wiki > infra/services/wiki.yaml

wiki-create:
    kubectl create -f infra/services/wiki.yaml

wiki-delete:
    kubectl delete -f infra/services/wiki.yaml
