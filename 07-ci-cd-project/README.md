# CI/CD Project

This project demonstrates a complete CI/CD pipeline using Docker, Jenkins, and Kubernetes.

## Project Structure

```
07-ci-cd-project/
├── README.md
├── Dockerfile
├── Jenkinsfile
└── k8s/
    ├── deployment.yaml
    └── service.yaml
```

## Overview

This project implements a CI/CD pipeline that:
1. Builds a Docker image from source code
2. Runs tests and quality checks
3. Builds and pushes Docker image to registry
4. Deploys to Kubernetes cluster

## Prerequisites

- Docker installed and running
- Jenkins with required plugins
- Kubernetes cluster access
- Docker registry (Docker Hub, ECR, etc.)

## Setup

### 1. Configure Jenkins

Install required plugins:
- Docker Pipeline
- Kubernetes CLI
- Git
- Pipeline

### 2. Configure Kubernetes Access

Ensure `kubectl` is configured and accessible from Jenkins.

### 3. Update Configuration

Update the following in `Jenkinsfile`:
- Docker registry credentials
- Kubernetes namespace
- Image names and tags

### 4. Create Jenkins Pipeline

1. Create new Pipeline job in Jenkins
2. Point to this repository
3. Set Jenkinsfile path: `Jenkinsfile`
4. Run pipeline

## Pipeline Stages

### 1. Checkout
- Checks out source code from repository

### 2. Build
- Installs dependencies
- Builds application

### 3. Test
- Runs unit tests
- Runs integration tests

### 4. Code Quality
- Runs linting
- Runs SonarQube analysis (if configured)

### 5. Docker Build
- Builds Docker image
- Tags image with version
- Pushes to registry

### 6. Security Scan
- Scans Docker image for vulnerabilities

### 7. Deploy
- Deploys to Kubernetes
- Updates deployment with new image

## Deployment

### Manual Deployment

```bash
# Build Docker image
docker build -t myapp:1.0.0 .

# Push to registry
docker push myapp:1.0.0

# Deploy to Kubernetes
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### Using Jenkins Pipeline

1. Push code to repository
2. Jenkins automatically triggers pipeline
3. Pipeline builds, tests, and deploys

## Kubernetes Deployment

The `k8s/` directory contains:
- `deployment.yaml`: Application deployment configuration
- `service.yaml`: Service configuration for exposing application

### Apply Kubernetes Manifests

```bash
kubectl apply -f k8s/
```

### Check Deployment Status

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

## Environment Variables

Configure these in Jenkins or Kubernetes:
- `ENVIRONMENT`: Deployment environment (dev/staging/prod)
- `DATABASE_URL`: Database connection string
- Other application-specific variables

## Monitoring

After deployment, monitor:
- Pod status: `kubectl get pods -w`
- Logs: `kubectl logs -f deployment/myapp`
- Service: `kubectl get svc`

## Troubleshooting

### Build Fails
- Check Docker daemon is running
- Verify Dockerfile syntax
- Check build logs in Jenkins

### Deployment Fails
- Verify Kubernetes cluster access
- Check deployment YAML syntax
- Review pod events: `kubectl describe pod <pod-name>`

### Image Pull Errors
- Verify registry credentials
- Check image exists in registry
- Verify image pull policy

## Best Practices

1. Use specific image tags (not `latest`)
2. Implement health checks
3. Set resource limits
4. Use secrets for sensitive data
5. Enable monitoring and logging
6. Implement rollback strategy
7. Use namespaces for environments
8. Tag resources appropriately

## Next Steps

- Add monitoring (Prometheus, Grafana)
- Implement blue-green deployments
- Add automated rollback
- Set up staging environment
- Configure notifications
- Add performance testing

