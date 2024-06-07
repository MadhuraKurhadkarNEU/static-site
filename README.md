# static-site
# Caddy Web Server with Jenkins Integration

This repository contains the necessary files to set up a Caddy web server that serves a static HTML page, along with configurations for Kubernetes and Jenkins to automate the deployment process.

## Repository Contents

- `Dockerfile`: Defines the Docker image for the Caddy web server.
- `Caddyfile`: Configuration file for the Caddy web server.
- `index.html`: Static HTML page content.
- `k8s`: Directory containing Kubernetes configuration files.
  - `configmap.yaml`: ConfigMap for Caddy configuration.
  - `pod.yaml`: Pod definition including readiness and liveness probes.
- `Jenkinsfile`: Jenkins pipeline script for building and publishing the Docker image.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- Docker
- Kubernetes (kubectl)
- Jenkins
- Git
- A Docker Hub account

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

git clone https://github.com/your-username/static-site.git
cd static-site

1. Build and Push Docker Image
Build and push the Docker image to your Docker Hub repository.

Build Docker Image
docker build -t your-dockerhub-username/caddy-web-server:latest .

Push Docker Image
docker login
docker push your-dockerhub-username/caddy-web-server:latest


3. Deploy to Kubernetes
Deploy the application to your Kubernetes cluster.

Create ConfigMap
kubectl apply -f k8s/configmap.yaml
Deploy Pod

kubectl apply -f k8s/pod.yaml
Verify Deployment
Check the status of the pod:


kubectl get pods
kubectl describe pod caddy-web-server


4. Set Up Jenkins Pipeline
Set up a Jenkins pipeline to automate the Docker image build and push process.

Jenkins Configuration
Install Docker Pipeline Plugin: Ensure you have the Docker Pipeline plugin installed in Jenkins.
Add Docker Hub Credentials: Add your Docker Hub credentials in Jenkins:
Go to "Manage Jenkins" > "Manage Credentials".
Add credentials with ID dockerhub-credentials-id.
Create Jenkins Pipeline Job
Create a new Jenkins pipeline job.
In the job configuration, select "Pipeline script from SCM".
Configure the SCM settings to point to your GitHub repository.
Ensure the script path is set to Jenkinsfile.
Configure Webhook
Go to your GitHub repository settings.
Navigate to "Webhooks".
Add a new webhook with the following settings:
Payload URL: http://your-jenkins-server/github-webhook/
Content type: application/json
Event: Just the push event.
5. Access the Application
Once the Kubernetes pod is running, you can access the application:


kubectl get pods -o wide
Find the external IP address and access the application in your browser:


http://<external-ip>:8080
Health Probes
The Kubernetes pod is configured with readiness and liveness probes:
Readiness Probe: Ensures the application is ready to serve traffic.
Liveness Probe: Ensures the application is running and responsive.
You can check the status of these probes using:
kubectl describe pod caddy-web-server

Terminate the Application
    To terminate the application, delete the pod:
    kubectl delete -f k8s/pod.yaml

Replace all instances of `your-dockerhub-username`, `your-username`, and `your-jenkins-server` with your actual DockerHub username, GitHub username, and Jenkins server URL, respectively.

