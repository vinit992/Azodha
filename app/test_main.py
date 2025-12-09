from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health():
    assert client.get("/health").status_code == 200

def test_predict():
    r = client.get("/predict")
    assert r.status_code == 200 and "score" in r.json()
