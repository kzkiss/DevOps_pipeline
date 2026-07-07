from fastapi import APIRouter

router = APIRouter()

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
        