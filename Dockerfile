FROM python:3.10-slim

WORKDIR /app

# Install dependencies
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ ./src/

# Expose the API port
EXPOSE 8000

# Run the FastAPI server
CMD ["uvicorn", "src.agent:app", "--host", "0.0.0.0", "--port", "8000"]
