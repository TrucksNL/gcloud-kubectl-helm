# syntax=docker/dockerfile:1
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

RUN gcloud components install kubectl gke-gcloud-auth-plugin

RUN apk add helm docker-cli

# Pinned to the sealed-secrets controller version running in both clusters.
ARG KUBESEAL_VERSION=0.24.3
ARG TARGETARCH
RUN case "$TARGETARCH" in \
        amd64) KUBESEAL_SHA256=44340fb7d8206937b59d356e1d12a4dd05cc6bbf8e6b4816a074c730a366a7a3 ;; \
        arm64) KUBESEAL_SHA256=a23fa1c2f80bc90e7b19b0c9fe016285b7086ec6e11e52d67950885e5ea2d3eb ;; \
        *) echo "unsupported TARGETARCH: $TARGETARCH" >&2; exit 1 ;; \
    esac \
    && curl -fsSL -o /tmp/kubeseal.tar.gz \
        "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-${TARGETARCH}.tar.gz" \
    && echo "${KUBESEAL_SHA256}  /tmp/kubeseal.tar.gz" | sha256sum -c - \
    && tar xzf /tmp/kubeseal.tar.gz -C /usr/local/bin kubeseal \
    && rm /tmp/kubeseal.tar.gz \
    && kubeseal --version
