# Simple Task Management App

A simple task management application built with React (frontend) and FastAPI (backend).

## Project Structure

```
simple-task-app/
├── backend/         # FastAPI backend
└── frontend/        # React frontend
```

## Setup Instructions

### Option 1: Docker Setup (Recommended)

1. Make sure you have Docker and Docker Compose installed on your system.

2. From the root directory, run:
```bash
docker-compose up --build
```

This will start both the frontend and backend services:
- Frontend will be available at http://localhost:3000
- Backend API will be available at http://localhost:8000

### Option 2: Manual Setup

#### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Create a virtual environment and activate it:
```bash
python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Run the backend server:
```bash
uvicorn main:app --reload
```

#### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start the development server:
```bash
npm start
```

## Features

- Create new tasks
- Update existing tasks
- Delete tasks
- Simple and clean UI 