# syntax=docker/dockerfile:1
FROM debian:stable-slim AS base

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates gnupg curl && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update && \
    apt-get install -y google-cloud-cli kubectl google-cloud-cli-gke-gcloud-auth-plugin && \
    wget -O- https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    apt-get remove -y apt-transport-https ca-certificates gnupg curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
