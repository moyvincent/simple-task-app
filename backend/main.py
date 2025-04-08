from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import uuid

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # React app's address
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Task model
class Task(BaseModel):
    id: Optional[str] = None
    title: str
    completed: bool = False

# In-memory storage for tasks
tasks = {}

@app.get("/tasks", response_model=List[Task])
async def get_tasks():
    return list(tasks.values())

@app.post("/tasks", response_model=Task)
async def create_task(task: Task):
    task.id = str(uuid.uuid4())
    tasks[task.id] = task
    return task

@app.put("/tasks/{task_id}", response_model=Task)
async def update_task(task_id: str, task: Task):
    if task_id not in tasks:
        raise HTTPException(status_code=404, detail="Task not found")
    task.id = task_id
    tasks[task_id] = task
    return task

@app.delete("/tasks/{task_id}")
async def delete_task(task_id: str):
    if task_id not in tasks:
        raise HTTPException(status_code=404, detail="Task not found")
    del tasks[task_id]
    return {"message": "Task deleted successfully"} 