# Azodha
Devops Assessment

# 🚀 Predictor Service — DevOps Deployment (EKS + GitHub Actions + ECR)

This repository implements a fully containerized microservice deployed on **AWS EKS using rolling updates**, CI/CD via **GitHub Actions**, image registry in **ECR**, and monitoring/alerts using **CloudWatch**.

The goal of this project is to demonstrate DevOps proficiency including automation, infrastructure-as-code, secure CI/CD, observability, and cloud-native deployment.


---

## 🔹 Features

| Component | Implementation |
|--------|----------------|
| API framework | FastAPI (Python) |
| Endpoints | `GET /health`, `GET /predict → {"score":0.75}` |
| Containerization | Multi-stage Dockerfile, non-root, healthcheck |
| Orchestration | Kubernetes (EKS) Deployment + Service + Ingress |
| CI/CD | GitHub Actions → Build → Test → Push → Deploy |
| Registry | Amazon ECR |
| Monitoring | CloudWatch Dashboard + CPU/Memory/Unhealthy alerts |
| Security | IAM least-privilege + ECR Scan + HTTPS via ALB+ACM |

---

## 🔧 Architecture
 ┌──────────────┐
Developer ───▶ │ GitHub Repo │
└───────┬──────┘
│ Push to main
┌───────▼────────┐
│ GitHub Actions │
│ CI → CD │
└───────┬────────┘
│ Build+Push to ECR
┌─────────────▼──────────────┐
│ Amazon ECR (images stored) │
└─────────────┬──────────────┘
│ Deploy new tag
┌─────────────▼───────────────┐
│ Amazon EKS (k8s cluster) │
│ Deployment + HPA-ready │
└─────────────┬───────────────┘
│ HTTP/HTTPS
┌─────────────▼──────────────┐
│ ALB Ingress (TLS via ACM) │
└─────────────┬──────────────┘
│
Client/User



---

## 🟦 API Endpoints

| Method | Path | Description |
|---|---|---|
| GET | `/health` | returns status `"ok"` |
| GET | `/predict` | returns `{ "score": 0.75 }` |

---

## ⚙ CI/CD Pipeline Workflow

### **CI Stage**
| Step | Action |
|---|---|
| 1 | Checkout source |
| 2 | Install Python deps |
| 3 | Run tests |

### **CD Stage**
| Step | Action |
|---|---|
| 4 | Build Docker image |
| 5 | Push to Amazon ECR |
| 6 | Update EKS Kubernetes Deployment |
| 7 | Rolling update → waits for new pods to become healthy |

Trigger: **any push to `main` branch**

---

## 🚀 Deployment Steps

### 1. Run Terraform to bootstrap infra:
```sh
cd infra
terraform init
terraform apply

2. Build & push image manually first time (optional)

docker build -t predictor .
docker tag predictor:latest <AWS_ID>.dkr.ecr.<REGION>.amazonaws.com/predictor:latest
docker push <AWS_ID>.dkr.ecr.<REGION>.amazonaws.com/predictor:latest

3. Deploy to EKS
kubectl apply -f k8s/

4. Push to GitHub → CI/CD auto rolls out update

Monitoring & Alerting

| Metric Source                    | Purpose                                 |
| -------------------------------- | --------------------------------------- |
| CloudWatch Container Insights    | CPU & Memory utilization                |
| ALB Metric: `UnHealthyHostCount` | Alerts if pod health fails              |
| CloudWatch Dashboard             | Live resource visualization             |
| SNS Alerts                       | CPU >80%, Mem >80%, ALB unhealthy hosts |

Security Controls

Non-root container user

AWS Secrets Manager/SSM for secret storage

IAM role for GitHub using OIDC (no stored IAM keys)

HTTPS termination via ALB + ACM certificate

ECR image scanning enabled


