#!/bin/bash

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
