# Gemini Project: Kubernetes GitOps with Flux

## Project Overview

This repository contains the configuration for a Kubernetes cluster managed using GitOps principles with Flux. It defines the desired state of the `staging` cluster, including deployed applications, infrastructure components, and monitoring solutions.

## Directory Overview

*   `apps/`: Contains the Kubernetes manifests for the applications deployed in the cluster.
*   `clusters/`: Contains the Flux Kustomization configurations for each cluster. The `staging` cluster is defined here.
*   `infrastructure/`: Contains the manifests for infrastructure components like controllers and other cluster-wide services.
*   `monitoring/`: Contains the configuration for the monitoring stack, which is based on `kube-prometheus-stack`.

## Key Technologies

*   **Kubernetes:** The container orchestration platform.
*   **Flux:** The GitOps tool used to keep the cluster in sync with this repository.
*   **Kustomize:** Used to customize Kubernetes configurations for different environments.
*   **Sops:** Used for managing encrypted secrets.

## Deployed Applications

The `staging` cluster deploys the following applications:

*   **AdGuard:** Network-wide ad-blocking DNS server.
*   **Audiobookshelf:** Self-hosted audiobook and podcast server.
*   **Homer:** A simple, static homepage for your server.
*   **Linkding:** A self-hosted bookmarking service.

## Infrastructure

The cluster's infrastructure includes:

*   **Cloudflare Tunnel:** Provides secure ingress to the cluster.
*   **Renovate:** Automated dependency updates for the Git repository.

## Monitoring

Monitoring is provided by the `kube-prometheus-stack`, which includes Prometheus for metrics collection and Grafana for visualization.

## Development Conventions

*   **GitOps:** All changes to the cluster are made through commits to this Git repository.
*   **Kustomize:** Application and infrastructure configurations are managed using Kustomize overlays.
*   **Secrets:** Secrets are encrypted using Sops and stored in the Git repository. To edit a secret, you will need the age key. You can edit the secrets with the command `sops -d <file>` make your changes and then encrypt the file again.

## Adding a new application

To add a new application to the cluster, you will need to:

1.  Create a new directory in `apps/base/<application-name>`.
2.  Add the Kubernetes manifests for the application to this new directory.
3.  Create a `kustomization.yaml` file in the same directory.
4.  Add the path to the new application to `apps/staging/kustomization.yaml`.
5.  Commit the changes to the Git repository. Flux will then automatically deploy the new application to the cluster.