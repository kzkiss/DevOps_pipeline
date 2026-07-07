from fastapi import FastAPI
from routes.api import router

app = FastAPI(
    title="Demo API",
    description="A simple API for demonstration purposes for DevOps pipeline.",
    version="1.0.0"
)
app.include_router(router)