# 🚀 End‑to‑End DevOps Project: Docker → GitHub → AWS ECS (Fargate)

## 📌 Project Summary

This project demonstrates a **complete, real‑world DevOps workflow** where an open‑source Python application is:

* Dockerized
* Deployed on **AWS ECS (Fargate)**
* Provisioned using **Terraform**
* Automatically deployed using **GitHub Actions CI/CD**
* Monitored via **AWS CloudWatch Logs**

The entire pipeline is fully automated — **no manual deployment steps**.

---

## 🎯 Objective

The goal of this project is to show practical DevOps skills, not theory.

This project answers:

* How to containerize an application
* How to deploy containers on AWS without managing servers
* How to automate deployments using CI/CD
* How to manage infrastructure using code

---

## 🧱 Architecture Overview

```
Developer
   ↓
GitHub Repository
   ↓
GitHub Actions (CI/CD)
   ├── Build Docker Image
   ├── Push Image to Amazon ECR
   └── Deploy to AWS ECS (Fargate)
        ↓
   Running Application
        ↓
   AWS CloudWatch Logs
```

---

## 🛠️ Technology Stack

| Layer              | Technology           |
| ------------------ | -------------------- |
| Application        | Python (Flask)       |
| Containerization   | Docker               |
| CI/CD              | GitHub Actions       |
| Infrastructure     | Terraform            |
| Cloud Provider     | AWS                  |
| Container Registry | Amazon ECR           |
| Orchestration      | Amazon ECS (Fargate) |
| Logging            | AWS CloudWatch       |

---

## 📁 Repository Structure

```
.
├── .github/workflows/
│   └── cicd.yml          # GitHub Actions CI/CD pipeline
├── infra/                # Terraform infrastructure files
├── Dockerfile            # Docker image configuration
├── main.py               # Flask application
├── requirements.txt      # Python dependencies
├── ecs-task.json         # ECS task definition
└── README.md
```

---

## ⚙️ How the Project Works (Step‑by‑Step)

### 1️⃣ Application Layer

A simple Python Flask application runs on port **5000**.

Purpose:

* Acts as a sample workload
* Outputs logs to demonstrate CloudWatch logging

---

### 2️⃣ Dockerization

The application is packaged into a Docker image using a `Dockerfile`.

Why Docker?

* Consistent runtime
* Easy deployment
* ECS compatibility

---

### 3️⃣ Infrastructure as Code (Terraform)

Terraform provisions:

* ECS Cluster
* ECS Service
* IAM roles
* Networking configuration

Benefits:

* Repeatable infrastructure
* Version‑controlled
* No manual AWS setup

---

### 4️⃣ Container Registry (Amazon ECR)

Docker images are stored in **Amazon ECR**.

Each CI/CD run:

* Builds a new image
* Pushes it to ECR

---

### 5️⃣ CI/CD Pipeline (GitHub Actions)

Triggered automatically on:

* `git push` to the main branch

Pipeline steps:

1. Checkout source code
2. Build Docker image
3. Authenticate to AWS
4. Push image to ECR
5. Force ECS service redeployment

No manual commands are required.

---

### 6️⃣ Deployment (AWS ECS Fargate)

* Application runs as an ECS task
* Fargate removes the need for EC2 management
* ECS handles restarts and availability

---

### 7️⃣ Logging & Monitoring

Logs are sent to **AWS CloudWatch Logs**:

```
/ecs/myapp
```

This allows:

* Debugging
* Application health monitoring
* Production‑level visibility

---

## 🔄 Deployment Flow

1. Developer pushes code to GitHub
2. GitHub Actions pipeline runs
3. Docker image is built
4. Image is pushed to Amazon ECR
5. ECS service deploys the new image
6. Application runs on AWS Fargate
7. Logs appear in CloudWatch

---
