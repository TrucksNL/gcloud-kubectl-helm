# syntax=docker/dockerfile:1
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine

RUN gcloud components install kubectl gke-gcloud-auth-plugin

RUN apk add helm
