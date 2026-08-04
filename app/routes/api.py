from fastapi import APIRouter, HTTPException

router = APIRouter()

#temporary data for demonstration purposes
tasks = [
    {"id": 1, "title": "Task 1"},
    {"id": 2, "title": "Task 2"}
]

@router.get("/")
def root():
    return {
        "application": "Demo API",
        "status": "running"
        }

@router.get("/health")
def health():
    return {
        "healthy": True
        }

@router.get("/version")
def version():
    return {
        "version": "1.0.0"
        }

@router.get("/tasks")
def get_tasks():
    return tasks

@router.get("/tasks/{task_id}")
def get_task(task_id: int):
    
    for task in tasks:
        if task["id"] == task_id:
            return task

    raise HTTPException(
        status_code=404, 
        detail="Task not found"
    )