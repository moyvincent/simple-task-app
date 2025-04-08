# Stage 1: Build React
FROM node:16 AS build-frontend
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ .
RUN npm run build
# At the end of this stage, we have a 'build' folder with static files

# Stage 2: Build the FastAPI container
FROM python:3.9-slim
WORKDIR /app

# Copy backend files
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ .

# Copy in React's build folder from Stage 1
COPY --from=build-frontend /app/build ./static

# Env var for Cloud Run
ENV PORT=8080

# Example: your FastAPI code might serve files in ./static
# e.g., using a library like `fastapi.staticfiles` or a custom route
#
# main.py snippet:
# app.mount("/", StaticFiles(directory="static", html=True), name="static")
#
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
