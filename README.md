# Simple Task Management App

A simple task management application built with React (frontend) and FastAPI (backend).

## Project Structure

```
simple-task-app/
├── backend/         # FastAPI backend
└── frontend/        # React frontend
```

## Setup Instructions

### Backend Setup

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

### Frontend Setup

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