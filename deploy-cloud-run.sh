#!/usr/bin/env zsh

# Exit on error
set -e

# Configuration
PROJECT_ID="dev-project-241408"  # Replace with your GCP project ID
REGION="us-central1"          # Replace with your preferred region
BACKEND_SERVICE="task-app-backend-service"
FRONTEND_SERVICE="task-app-frontend-service"
BACKEND_IMAGE="docker.io/vinopaul/task-app-backend:latest"
FRONTEND_IMAGE="docker.io/vinopaul/task-app-frontend:v1"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "gcloud CLI is not installed. Please install it first."
    exit 1
fi

# Check if user is authenticated with gcloud
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q "@"; then
    echo "You are not authenticated with gcloud. Please run 'gcloud auth login' first."
    exit 1
fi

# Set the project
echo "Setting project to $PROJECT_ID..."
gcloud config set project $PROJECT_ID

# Deploy backend to Cloud Run
echo "Deploying backend to Cloud Run..."
gcloud run deploy $BACKEND_SERVICE \
  --image $BACKEND_IMAGE \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --set-env-vars="CORS_ORIGINS=https://$FRONTEND_SERVICE-$(gcloud run services describe $FRONTEND_SERVICE --region $REGION --format='value(status.url)' 2>/dev/null || echo 'localhost:3000')"

# Get the backend URL
BACKEND_URL=$(gcloud run services describe $BACKEND_SERVICE --region $REGION --format='value(status.url)')
echo "Backend deployed at: $BACKEND_URL"

# Deploy frontend to Cloud Run
echo "Deploying frontend to Cloud Run..."
gcloud run deploy $FRONTEND_SERVICE \
  --image $FRONTEND_IMAGE \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --set-env-vars="REACT_APP_API_URL=$BACKEND_URL"

# Get the frontend URL
FRONTEND_URL=$(gcloud run services describe $FRONTEND_SERVICE --region $REGION --format='value(status.url)')
echo "Frontend deployed at: $FRONTEND_URL"

echo "Deployment complete!"
echo "Frontend URL: $FRONTEND_URL"
echo "Backend URL: $BACKEND_URL"
