
---

# ♾️ CI/CD Pipeline Using Jenkins, Ansible & Docker on AWS EC2

This project automates the end-to-end deployment of a web application using **Jenkins, Ansible, and Docker**, hosted on AWS EC2 instances for a seamless CI/CD experience.

---

## 📋 Project Overview

✅ **Jenkins Server:**
- **OS:** RHEL 9  
- **Instance Type:** t2.medium  
- **Allowed Port:** 8080  

✅ **Ansible Server:**  
- **OS:** RHEL 9  
- **Instance Type:** t2.large  
- **Allowed Ports:** 80, 443  

✅ **Docker/Web Server:**  
- **OS:** RHEL 9  
- **Instance Type:** t2.medium  
- **Allowed Ports:** 80, 443  

![Visual](/Assests/visual.png)

---

## 📂 Project Structure

```
├── Assests            # Project Images
├── Dockerfile         # Docker configuration to build the application
├── build.sh           # Shell script to build and push Docker image
├── docker.yaml        # Ansible playbook to deploy the Docker container
└── local.repo         # Custom repository configuration (if applicable)
```

---

## 🏗️ Project Architecture
![Deployed Application](/Assests/Project%20Architecture.jpg)

## 🎯 Expected Outcomes
- ✅ Successful deployment of the application on AWS EC2 using Docker and Ansible.  
- ✅ Proper configuration of Jenkins for automated builds, triggers, and deployment pipelines.  
- ✅ Secure and seamless file transfer and execution between Jenkins, Ansible, and Docker servers.  
- ✅ Docker container accessible via the public IP or domain on port **80** using NodePort.  
- ✅ Hands-on experience with managing CI/CD pipelines, Docker containerization, and Ansible playbook execution.  
- ✅ Done! Your web application is now successfully deployed and running on the target server! 🎉  
![Deployed Application](/Assests/Deployed-Application.png)


---

## ⚙️ Configuration Steps

### 1. 🎯 Setup Jenkins Server
- Installed Jenkins and configured it on **port 8080**.
- Installed necessary plugins:
  - Git
  - Docker Pipeline
  - Ansible
  - SSH Publisher
- Created a **webhook** in the GitHub repository with Jenkins payload URL to trigger the pipeline.

### 2. 🛠️ Configure Ansible Server
- Configured Ansible and Docker.
![Image2](/Assests/Docker-Setup.png)
![Image2](/Assests/Jenkins-Setup.png) 
- Established **passwordless authentication** using `ssh-keygen` between:
  - Jenkins Server → Ansible Server
  - Ansible Server → Docker/Web Server

### 3. 📦 Configure Docker/Web Server
- Installed and configured Docker.
- Ensured passwordless authentication with the Ansible Server.
- Configured Docker login to push images to Docker Hub.

---

## ⚡️ CI/CD Pipeline Workflow Overview

### 🎯 Step 1: Trigger via Webhook  
When changes are pushed to the GitHub repository, the Jenkins pipeline is automatically triggered using a webhook.

```bash
Repository URL: https://github.com/kartikk26/myproject.git
```

---

### 📡 Step 2: Sync Files to Ansible Server  
Files from the Jenkins workspace are synced to the Ansible Server using `rsync` for further processing.

```bash
rsync -avh /var/lib/jenkins/workspace/project-a/* root@<ANSIBLE_SERVER_IP>:/root/ansible
```

---

### 🐳 Step 3: Build Docker Image & Push to Docker Hub  
The Docker image is built, tagged, and pushed to **Docker Hub** for version management and deployment.

```bash
cd /root/ansible

# Build Docker Image
docker build -t $JOB_NAME:$BUILD_ID .

# Tag Image
docker tag $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:$BUILD_ID
docker tag $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:latest

# Push to Docker Hub
docker push kartikjain26/$JOB_NAME:$BUILD_ID
docker push kartikjain26/$JOB_NAME:latest

# Clean up Docker Images
docker rmi -f $JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:$BUILD_ID kartikjain26/$JOB_NAME:latest
```

---

### ⚙️ Step 4: Deploy Using Ansible Playbook  
Ansible is used to deploy the Docker container to the target server.

```bash
cd /root/ansible

# Run Ansible Playbook
ansible-playbook docker.yaml
```

---

## 📜 Jenkins Pipeline Script

```groovy
pipeline {
    agent any
    stages {
        stage('Trigger Webhook') {
            steps {
                echo 'Webhook triggered, starting pipeline...'
            }
        }
        stage('Sync Files to Ansible Server') {
            steps {
                sh 'rsync -avz ./ ansible_user@<ansible-server-ip>:/home/ansible_user/project'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                sh './build.sh'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i /etc/ansible/hosts docker.yaml'
            }
        }
    }
}
```

## ⚓️ Sucessfull Deployed Pipleline 
![Image2](/Assests/Pipeline1.png)
![Image2](/Assests/Pipeline2.png)

---

## 🔐 Authentication & Security
- Configured SSH key-based authentication between all servers.
- Enabled secure communication for Jenkins webhook.
- Implemented firewall rules and security groups on AWS EC2 instances.

---

## 📢 Usage Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Kartikk-26/CI-CD-Pipeline-Project.git
```

### 2. Configure Environment Variables
- **Jenkins Webhook URL**  
- **Docker Hub Credentials**  
- **Ansible Inventory File**  

### 3. Run the Jenkins Pipeline
- Execute the pipeline and access the deployed application!

---

## 🧩 Troubleshooting

- Verify that all security groups allow traffic on required ports.
- Confirm passwordless SSH keys are properly configured between servers.
- Check Jenkins build logs for error messages if the pipeline fails.
- Ensure Docker login credentials are correctly configured.

---

## 📡 Live Website Access

- **Public IP of Docker Server:** `http://<docker-server-public-ip>`  
![Deployed Application](/Assests/Deployed-Application.png)
- The application becomes accessible after a successful Jenkins build and Ansible deployment.

---

## 📝 Conclusion
- ✅ Successfully automated the deployment of a web application using **Jenkins, Ansible, and Docker** hosted on AWS EC2 instances.  
- ✅ Ensured secure and seamless integration between Jenkins, Ansible, and Docker servers with passwordless authentication.  
- ✅ Configured a robust CI/CD pipeline that efficiently builds, pushes, and deploys Docker containers to production.  

---
## 📢 Let's Connect!
- Stay updated on [LinkedIn](https://www.linkedin.com/in/-kartikjain/) for more DevOps projects and insights.
- Follow along as I explore **Cloud Infrastructure, Ansible Automation, and DevOps practices**.
- Let's collaborate and build scalable solutions together!

---

