#!/bin/bash

# Set the region
export REGION="eu"

# Create Instance Group
gcloud compute instance-groups unmanaged create talos-ig \
  --zone "$REGION"

# Create port for IG
gcloud compute instance-groups set-named-ports talos-ig \
  --named-ports tcp6443:6443 \
  --zone "$REGION"

# Create health check
gcloud compute health-checks create tcp talos-health-check --port 6443

# Create backend service
gcloud compute backend-services create talos-be \
  --global \
  --protocol TCP \
  --health-checks talos-health-check \
  --timeout 5m \
  --port-name tcp6443

# Add instance group to backend
gcloud compute backend-services add-backend talos-be \
  --global \
  --instance-group talos-ig \
  --instance-group-zone "$REGION"

# Create TCP proxy
gcloud compute target-tcp-proxies create talos-tcp-proxy \
  --backend-service talos-be \
  --proxy-header NONE

# Create Load Balancer IP
gcloud compute addresses create talos-lb-ip --global

# Forward 443 from LB IP to TCP proxy
gcloud compute forwarding-rules create talos-fwd-rule \
  --global \
  --ports 443 \
  --address talos-lb-ip \
  --target-tcp-proxy talos-tcp-proxy

# Create the control plane nodes
for i in $(seq 1 2); do
  gcloud compute instances create talos-controlplane-$i \
    --image talos \
    --zone "europe-southwest1-a" \
    --tags talos-controlplane,talos-controlplane-$i \
    --boot-disk-size 100GB \
    --machine-type n2-highcpu-4 \
    --boot-disk-type pd-standard
done

# Add control plane nodes to instance group
for i in $(seq 1 2); do
  gcloud compute instance-groups unmanaged add-instances talos-ig \
    --zone "$REGION" \
    --instances talos-controlplane-$i
done

# Create worker nodes
for i in $(seq 1 2); do
  gcloud compute instances create talos-worker-$i \
    --image talos \
    --zone "europe-west9-a" \
    --tags talos-worker,talos-worker-$i \
    --boot-disk-size 100GB \
    --machine-type n2-highcpu-2 \
    --boot-disk-type pd-standard
done
