from fastapi import APIRouter

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