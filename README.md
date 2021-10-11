# devops-exercise

| Pipelines Status |
| -|
| ![Litecoin docker image builder ](https://github.com/suren-m/devops-exercise/actions/workflows/litecoin-image-builder.yml/badge.svg) |
| ![AKS cluster deployment](https://github.com/suren-m/devops-exercise/actions/workflows/aks-cluster.yml/badge.svg) |
| ![StatefulSet release](https://github.com/suren-m/devops-exercise/actions/workflows/gitops-deploy-statefulset.yml/badge.svg) |

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
![Screenshot from 2021-10-11 16-45-55](https://user-images.githubusercontent.com/3830633/136818940-8fae120d-f979-4457-a849-1c4d8379329c.png)


## 3. CI / CD workflows for Deploying the K8s app

* All Github Action Workflows are located in `.github/workflows` directory
* Upon merging the pull request raised from `Step 1`(pushing the image and making updates to kustomize config), a new release is created through `gitops-deploy-statefulset.yml`
* The ArgoCD app on `aks` cluster is set to auto sync and deploy upon new Tags / Releases to Main branch

## 4. Text Manipulation problem using Bash & GNU tools

* The solution `images_repo_tag_lister.sh` in `4_script_based_text_manipulation` directory demonstrates the usage of tools such as `grep`, `awk`, `sed`, `tr` to filter and display docker images in `repo:tag` format
![Screenshot from 2021-10-11 16-20-30](https://user-images.githubusercontent.com/3830633/136815395-e27f3d72-cc16-4962-b8c9-3f7c6e278308.png)

## 5. Text Manipulation problem using Rust 

* The solution in `5_rust_based_text_manipulation` solves the above problem using Rust.
![Screenshot from 2021-10-11 16-17-49](https://user-images.githubusercontent.com/3830633/136815113-89361c47-6982-43f5-b184-078c825cd3e2.png)
![Screenshot from 2021-10-11 16-19-27](https://user-images.githubusercontent.com/3830633/136815289-5e5a4370-d243-4800-ae1a-a1b257313d8a.png)


