#!/usr/bin/bash

aws eks update-kubeconfig --region us-east-1 --name zephyr-eks
helm install argocd Charts/argo-cd -f Charts/argo-cd/argocd-values.yml -n argocd --create-namespace

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d


