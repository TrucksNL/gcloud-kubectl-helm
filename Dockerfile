# syntax=docker/dockerfile:1
FROM gcr.io/projectsigstore/cosign:v2.4.1 AS cosign

FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

COPY --from=cosign /ko-app/cosign /usr/local/bin/cosign

RUN gcloud components install kubectl gke-gcloud-auth-plugin

RUN apk add helm docker-cli docker-cli-buildx
