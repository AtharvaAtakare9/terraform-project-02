# 🚀 AWS DevOps Project using Terraform

---

## 📌 Overview

This project demonstrates a **production-grade AWS infrastructure** built using **Terraform (Infrastructure as Code)**. It simulates a real-world DevOps setup with scalable, secure, and highly available architecture.

The application is deployed on **EC2 instances (Nginx)** behind an **Application Load Balancer**, with infrastructure split across **public and private subnets**.

---

## 🏗️ Architecture

![Architecture Diagram](Screenshots/architecture.png)

### 🔄 Request Flow

```
User → Internet → ALB (Public Subnet) → EC2 (Private Subnet) → RDS (Private Subnet)
```

---

## ⚙️ Tech Stack

* **Cloud**: AWS (VPC, EC2, ALB, ASG, RDS, NAT Gateway)
* **IaC**: Terraform
* **OS**: Amazon Linux
* **Web Server**: Nginx

---

## 📁 Project Structure

```
terraform-project/
│
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── modules/
│   ├── network/
│   ├── alb/
│   ├── compute/
│   └── database/
│
├── screenshots/
└── README.md
```

---

## 🚀 Deployment Steps

### 1️⃣ Initialize Terraform

```bash
terraform init
```

📸 *Terraform Initialization Output*
![Terraform Init](Screenshots/terraform-init.png)

---

### 2️⃣ Plan Infrastructure

```bash
terraform plan
```

📸 *Terraform Plan Output*
![Terraform Plan](Screenshots/terraform-plan.png)

---

### 3️⃣ Apply Configuration

```bash
terraform apply
```

📸 *Terraform Apply Output*
![Terraform Apply](Screenshots/terraform-apply.png)

---

## 🌐 Application Access

After deployment:

* Copy **ALB DNS name**
* Open in browser:

```
http://<your-alb-dns>
```

📸 *Application Running via ALB*
![ALB Output](Screenshots/alb-output.png)

---

## ⚙️ AWS Resources Verification

### 🔹 Load Balancer

📸
![ALB Details](Screenshots/alb-details.png)

---

### 🔹 Target Group Health

📸
![Target Group Healthy](Screenshots/target-group.png)

---

### 🔹 EC2 Instances (Auto Scaling)

📸
![EC2 Instances](Screenshots/ec2.png)

---

### 🔹 VPC & Subnets

📸
![VPC Setup](Screenshots/vpc.png)

---

## 🧪 Testing

### SSH into EC2

```bash
ssh -i key.pem ec2-user@<public-ip>
```

### Verify Nginx

```bash
curl localhost
```

Expected:

```
Hello from Terraform 🚀
```

📸 *Nginx Output*
![Nginx Test](Screenshots/nginx-test.png)

---


