from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Predictor Service")

class PredictResponse(BaseModel):
    score: float

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/predict", response_model=PredictResponse)
def predict():
    return {"score": 0.75}
