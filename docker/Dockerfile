FROM python:3.11-slim AS builder
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --upgrade pip && pip wheel  --no-cache-dir -r requirements.txt -w /wheels

FROM python:3.11-slim
RUN useradd -m appuser
WORKDIR /app
COPY --from=builder /wheels /wheels
COPY app /app
USER appuser

EXPOSE 8080
HEALTHCHECK CMD curl -f http://localhost:8080/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
