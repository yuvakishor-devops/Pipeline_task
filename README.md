#  Netflix DevOps Project

### (CI/CD + Docker + Terraform + AWS Deployment)

---

##  Project Overview

This project demonstrates a **complete end-to-end DevOps workflow**:

* Application development using Node.js
* CI/CD automation using Jenkins
* Containerization using Docker
* Infrastructure provisioning using Terraform
* Automated deployment on AWS EC2

---

##  Architecture

```text
Developer → GitHub → Jenkins → Docker Build → DockerHub → Terraform → AWS EC2 → Docker Container → Application Live
```

---

## 🛠️ Tech Stack

* **Node.js (Express)**
* **Jenkins (CI/CD)**
* **Docker**
* **Terraform**
* **AWS (EC2, VPC, Security Group)**
* **Git & GitHub**

---

#  Prerequisites & Installation

##  Install Node.js

```bash
sudo apt update
sudo apt install nodejs npm -y
node -v
npm -v
```

---

##  Install Docker

```bash
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version
```

---

##  Install Jenkins

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

---

##  Install Terraform

```bash
sudo apt update
sudo apt install unzip -y

wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
unzip terraform_1.7.5_linux_amd64.zip
sudo mv terraform /usr/local/bin/

terraform -v
```

---

##  Configure AWS CLI

```bash
sudo apt install awscli -y
aws configure
```

Provide:

* AWS Access Key
* AWS Secret Key
* Region (e.g., ap-south-1)

---

#  Project Structure

```text
Pipeline_task/
│
├── Dockerfile
├── Jenkinsfile
├── package.json
├── server.js
├── index.html
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── security.tf
│   ├── outputs.tf
│   └── modules/
│       └── ec2/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
```

---

#  Docker Implementation

## Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
```

## Why `--only=production`?

* Reduces image size
* Improves security
* Removes unnecessary dev dependencies

---

#  Jenkins CI/CD Pipeline

## Pipeline Stages

1. Checkout Code
2. Install Dependencies
3. Lint
4. Test
5. Build Docker Image
6. Run Container (Local Testing)
7. Push Image to DockerHub

---

#  Terraform Infrastructure

## Resources Created

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Security Group
* EC2 Instance

---

## EC2 Auto Deployment (Important)

Terraform uses **user_data** to:

* Install Docker
* Pull Docker image from DockerHub
* Run container automatically

---

## Terraform Commands

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

---

#  Step-by-Step Execution

---

## Step 1: Push Code

```text
Developer pushes code to GitHub (feature branch)
```

---

##  Step 2: Jenkins Pipeline

```text
✔ Installs dependencies
✔ Runs lint & test
✔ Builds Docker image
✔ Pushes image to DockerHub
```

---

##  Step 3: Infrastructure Creation

```bash
cd terraform
terraform apply
```

```text
✔ Creates EC2 + networking
✔ Runs user_data script
```

---

##  Step 4: Application Deployment

```text
✔ Docker installed automatically
✔ Image pulled from DockerHub
✔ Container started automatically
```

---

##  Step 5: Access Application

```text
http://<EC2-Public-IP>:5000
```

---

#  Best Practices Followed

* Used `.gitignore` to avoid sensitive files
* Docker image optimized for production
* Separated CI/CD and infrastructure
* Used feature branch workflow
* Avoided over-engineering pipeline

---

#  Key Highlights

* End-to-end DevOps pipeline
* Infrastructure as Code (Terraform)
* Automated Docker deployment
* Real-world project structure

---

#  Future Enhancements

* Terraform integration with Jenkins
* Remote backend (S3 + DynamoDB)
* Monitoring using CloudWatch
* Kubernetes deployment

---

#  Interview Explanation

> I built a CI/CD pipeline using Jenkins and Docker, and provisioned infrastructure using Terraform.
> I used Terraform user_data to automatically deploy the application on EC2.
> I separated CI/CD and infrastructure to keep the system simple and maintainable.

---

# 👨‍💻 Author

**Yuva**
DevOps Engineer

---

#  Conclusion

This project demonstrates a real-world DevOps implementation from code commit to production deployment using modern tools and best practices.

---

👉 If you found this useful, please ⭐ the repository!

