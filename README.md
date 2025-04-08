
# 🚀 Zephyr DevOps Project: AWS EKS + GitOps + Observability

Welcome to the **Zephyr DevOps Project**—a cloud-native infrastructure setup that’s not only battle-tested and production-ready, but also full of love for automation, creativity, and clean code. 💙

This project is a complete, end-to-end CI/CD pipeline and infrastructure deployment using the best DevOps practices. It's built on top of **Amazon EKS**, with infrastructure managed through **Terraform**, **Ansible**, and **Helm**, and incorporates **GitOps** principles with **ArgoCD**, plus observability with **Prometheus**, **Grafana**, and **SonarQube**.

![app](https://raw.githubusercontent.com/Ahmd-Sadka/3-tier-todo-devsecops-application/main/pnq/app.png)
---

## 🌟 Key Features

- **Modular Terraform Code** for EKS, S3, IAM, Backup, and more.
- **Dynamic Storage Provisioning** using the EBS CSI driver.
- **Ingress Controller** using the AWS Load Balancer Controller.
- **Multi-Branch Jenkins CI/CD Pipelines** for building and deploying Node.js + React apps.
- **GitOps with ArgoCD**: Git is the single source of truth.
- **Observability**: Prometheus + Grafana for monitoring. SonarQube for code quality.
- **Secure Secrets Handling** with Kubernetes secrets and manual credential setup for maximum control.
- **Best Practices Everywhere**: Prevent-destroy lifecycle rules, remote backend with locking, least privilege IAM roles, and more!

---

## 🧩 Tech Stack

| Tool        | Purpose                        |
|-------------|--------------------------------|
| AWS EKS     | Managed Kubernetes             |
| Terraform   | Infrastructure as Code (IaC)   |
| Ansible     | Configuration Management       |
| Helm        | Kubernetes Package Management  |
| Jenkins     | CI/CD Automation               |
| ArgoCD      | GitOps Continuous Delivery     |
| Prometheus  | Metrics Collection             |
| Grafana     | Dashboards & Visualization     |
| SonarQube   | Code Quality Analysis          |
| GitHub      | Version Control + Webhooks     |
| Docker      | Containerization               |
| Trivy       | Vulnerability Scanning         |
| AWS Backup  | Snapshot Management            |
| slack       | Notification Channel           |

---

## 📸 Architecture Overview

- S3 Remote Backend configured via Terraform then state removed.
- VPC & networking configured via Terraform.
- EKS Cluster with autoscaling node groups.
- Jenkins deployed on EC2 with AWS Backup snapshot enabled.
- Helm installs apps into EKS (argocd, aws-load-balancer-controller, ebs-csi).
- argocd installs dynamic apps into EKS (sonarqube, kube-prometheus, appChart).
- CI/CD pipeline SAST SonarQube, builds/pushes images to ECR or DockerHub, update Chart values.
- Monitoring + alerts using Prometheus & Grafana.
- GitOps syncing with ArgoCD.

---

## ✅ Getting Started

### Prerequisites

- AWS CLI, kubectl, eksctl, Terraform, Helm, Ansible, Docker
- GitHub Token with repo permissions
- IAM User/Role with necessary permissions

### 1. Clone the repo

```bash
git clone https://github.com/Ahmd-Sadka/3-tier-todo-devsecops-application.git
cd 3-tier-todo-devsecops-application
```

### 2. Create S3 Remote Backend (First Time Only)

```bash
cd todos-infra
terraform apply -target=module.s3
terraform state rm module.s3  # if you want to Prevents accidental deletion
```

Or use:

```hcl
lifecycle { prevent_destroy = true }
```

### 3. Deploy the Infra

```bash
terraform init
terraform apply
```

### 4. Configure Kubeconfig

```bash
aws eks update-kubeconfig --region us-east-1 --name zephyr-eks
```
### 5. Install ArgoCD

```bash
chmod +x argocdsh
./argocdsh


###6. Install Helm Charts

non changed values helm charted installed using terraform

```bash
cd applications
kubectl apply -f .
```

---
### Congrats! You're all set up!

## 🚀 Next Steps 

### 7. Ansible configurations roles

```bash
cd AnsibleRoles
ansible-playbook lets-go.yml --ask-vault-pass
```
### now jenkins is ready to use

you can now access jenkins on http://<public_ip>:8080 and dont forget to read the repo to know the username and password

### 8. jenkins pipeline

### go to any branch and customize the jenkinsfile as you need
--------------------------------------------------------------

  - create a new job
  - configure the job and provide needed credentials git, sonarqube, dockerhub, etc
  - add required plugins
  - manage system configurations environment variables
  - add webhook trigger "http://<public_ip>:8080/github-webhook" ### for multipipeline branch use https://<public_ip>:8080/multibranch-webhook-trigger/invoke?token=token
  - add tools you need
  - save the job
  - now you can start the pipeline and build the app.

![jenkins pipeline](https://github.com/Ahmd-Sadka/3-tier-todo-devsecops-application/blob/main/png/jenkins.png?raw=true)

### 9. sonarqube

  - go to http://<load_balancer_url>/quality
  - login with your credentials
  - create a new project for each branch
  - configure the project and create a token
  - add webhook trigger "http://<public_ip>:8080/sonarqube-webhook"
  - save the project

### 10. ArgoCD

  - go to http://<load_balancer_url>/argocd to see the your apps

### 11. Observability

  - go to http://<load_balancer_url>/prometheus to see the metrics and targets
  - go to http://<load_balancer_url>/grafana to see the dashboards
  - go to http://<load_balancer_url>/alertmanager to see the alerts

### 12. Notifications
  
  - create a slack channel
  - create a slack app
  - add webhook trigger "http://<public_ip>:8080/slack-webhook"
  - go to slack to see the notifications and alerts


## 
# 🔒 Security Best Practices

- Manual secrets setup for critical credentials.
- Prevent destruction of stateful resources.
- Use `create_before_destroy` to ensure no downtime.
- Least privilege IAM and proper service accounts.

---

## 🧠 Pro Tips

- Patch Node Exporter mount issue:  
  ```bash
  kubectl patch ds prometheus-prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]'
  ```
- Access Grafana Password:
  ```bash
  kubectl --namespace eye get secrets show-time-grafana -o jsonpath="{.data.admin-password}" | base64 -d
  ```

- Disable webhook before updating files to prevent CI/CD loops.

---

## 🤓 Quote of the Project

> “In a world full of manual steps, be the script that automates.” – Someone DevOpsy 💡

---

## ❤️ Credits

Made with ☕, 💻, and a touch of YAML by ME.  
Inspired by a vision for fast, reliable, and scalable deployments.

---

## 📜 License

This project is licensed.

