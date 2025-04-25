#!/usr/bin/env zsh

# Exit on error
set -e

# Configuration
DOCKER_USERNAME="vinopaul"  # Replace with your Docker Hub username

# Build and push backend image
echo "Building and pushing backend Docker image..."
docker-compose build backend

docker tag simple-task-app_backend:latest $DOCKER_USERNAME/task-app-backend:latest
docker push $DOCKER_USERNAME/task-app-backend:latest

# Build and push frontend image
echo "Building and pushing frontend Docker image..."
docker-compose build frontend

docker tag simple-task-app_frontend:latest $DOCKER_USERNAME/task-app-frontend:latest
docker push $DOCKER_USERNAME/task-app-frontend:latest

echo "Docker images have been built and pushed successfully!"
