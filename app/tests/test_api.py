from fastapi.testclient import TestClient
from main import app

#using TestClient to simulate user requests without a web server
client = TestClient(app)

def test_root():
    response = client.get("/") # simulates a GET request to the root endpoint
    assert response.status_code == 200 #checks if the response status code is 200 (OK)
    data = response.json()
    assert data["status"] == "running" #verifies the returned JSON, status equals running

def test_health():
    response = client.get("/health") # simulates a GET request to the health endpoint
    assert response.status_code == 200 #checks if the response status code is 200 (OK)
    data = response.json()
    assert data["healthy"] == True #verifies the returned JSON, healthy equals True

def test_version():
    response = client.get("/version") # simulates a GET request to the version endpoint
    assert response.status_code == 200 #checks if the response status code is 200 (OK)
    data = response.json()
    assert data["version"] == "1.0.0" #verifies the returned JSON, version number.

def test_tasks():
    response = client.get("/tasks") # simulates a GET request to the tasks endpoint
    
    print(response.status_code) #prints the response status code for debugging purposes
    print(response.json()) #prints the response JSON for debugging purposes

    assert response.status_code == 200 #checks response status code is 200 (OK)
    tasks = response.json()
    assert len(tasks) == 2 #check number of tasks, should return 2 as expected

def test_get_single_task():
    response = client.get("/tasks/1") # simulates a GET request to the tasks endpoint with id 1
    
    
    print(response.status_code) #prints the response status code for debugging purposes
    print(response.json()) #prints the response JSON for debugging purposes

    assert response.status_code == 200 #checks response status code is 200 (OK)
    task = response.json()
    assert task["id"] == 1 #check correct task id
    assert task["title"] == "Task 1" #check icorrect task title

#Fail case
def test_task_not_found():
    response = client.get("/tasks/999") # simulates a GET request to the tasks endpoint with a non-existent id
    assert response.status_code == 404 #checks response status code is 404 (Not Found)