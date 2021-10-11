# devops-exercise

![Litecoin docker image builder](https://github.com/suren-m/devops-exercise/actions/workflows/aks-cluster.yml/badge.svg) 
![AKS cluster deployment](https://github.com/suren-m/devops-exercise/actions/workflows/gitops-deploy-statefulset.yml/badge.svg) 
![StatefulSet release](https://github.com/suren-m/devops-exercise/actions/workflows/litecoin-image-builder.yml/badge.svg) 

This repo contains the completed solution for the following:

## 1. Litecoin Docker Image (build, scan, push & pull request)

* Dockerfile located in `1_litecoin_docker` directory
* The CI workflow for building, scanning and pushing the image is located in `.github/worfklows/litecoin-image-builder.yml` workflow
    * The above workflow will also raise a pull request to update the image version in Kustomize config.

## 2. Kubernetes Cluster and Stateful Set

The `2_k8s` directory contains the follows:

* `aks_cluster_provisioning` - Terraform template for creating a basic aks cluster that is deployed using `aks-cluster.yaml` GitHub Action workflow.
* `kustomization` - Directory for K8s manifests including the `statefulset` and `pvc` for litecoin
    * base - contains `statefuset.yml`
    * litecoin-exercise-demo - contains namespace resource and a couple of overrides
* `argocd-app` - Manifest for ArgoCD app used during deployment

## CI / CD workflows for Deploying the K8s app

* All Github Action Workflows are located in `.github/workflows` directory
* Upon merging the pull request raised from `Step 1`(pushing the image and making updates to kustomize config), a new release is created through `gitops-deploy-statefulset.yml`
* The ArgoCD app on `aks` cluster is set to auto sync and deploy upon new Tags / Releases to Main branch


