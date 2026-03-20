import os
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from llama_index.llms.ollama import Ollama
from openinference.instrumentation.llama_index import LlamaIndexInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import SimpleSpanProcessor

# ---------------------------------------------------------
# 1. SETUP GOVERNANCE TRACING (Connecting to Arize Phoenix)
# ---------------------------------------------------------
phoenix_endpoint = os.getenv("PHOENIX_COLLECTOR_ENDPOINT", "http://localhost:6006/v1/traces")
tracer_provider = TracerProvider()
tracer_provider.add_span_processor(SimpleSpanProcessor(OTLPSpanExporter(phoenix_endpoint)))
LlamaIndexInstrumentor().instrument(tracer_provider=tracer_provider)

# ---------------------------------------------------------
# 2. SETUP LOCAL INTELLIGENCE (Connecting to Ollama)
# ---------------------------------------------------------
ollama_url = os.getenv("OLLAMA_URL", "http://localhost:11434")
# We use a tiny model for fast simulation purposes
llm = Ollama(model="qwen2.5:0.5b", base_url=ollama_url, request_timeout=60.0)

# ---------------------------------------------------------
# 3. SETUP API (The Orchestrator Interface)
# ---------------------------------------------------------
app = FastAPI(title="Sovereign AI Orchestrator API")

class PromptRequest(BaseModel):
    prompt: str

@app.post("/api/v1/orchestrate")
async def orchestrate_agent(request: PromptRequest):
    try:
        print(f"🤖 Received Prompt: {request.prompt}")
        print("🔍 Routing to Local LLM (Ollama)...")
        
        # This execution is automatically traced and sent to Phoenix
        response = llm.complete(request.prompt)
        
        print("✅ Response received. Trace sent to Governance Dashboard.")
        return {"status": "success", "response": response.text}
    except Exception as e:
        print(f"❌ Error during orchestration: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
async def health_check():
    return {"status": "Sovereign Agent is Online"}
