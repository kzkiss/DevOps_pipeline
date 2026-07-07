#Use ligthweight python image
FROM python:3.12-slim

# Disable Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1 
#Immedeiately show output from python to the terminal without buffering
ENV PYTHONUNBUFFERED=1

#Set working directoty
WORKDIR /

#copy and install dependencies
COPY app/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY app /app

#Expose FastAPI port
EXPOSE 8000

#Start the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

