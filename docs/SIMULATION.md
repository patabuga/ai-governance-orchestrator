# AI Governance Simulation

> Private AI Orchestration Stack - Simulation Guide

## Overview

AI Governance is a sovereign AI orchestration system that demonstrates private LLM management, observability, and governance. This simulation allows you to experience a complete AI governance stack locally.

## Prerequisites

- Docker 20.10+
- Docker Compose v2+
- Node.js 18+
- 8GB+ RAM recommended (for Ollama)
- 10GB+ disk space

## Quick Start

### Option 1: Using vsp-porto (Recommended)

```bash
# Install vsp-porto
curl -fsSL https://porto.vspatabuga.io/ | sh

# Install AI Governance simulation
vsp-porto install ai-gov

# Start the simulation
vsp-porto start ai-gov -o

# View logs
vsp-porto logs ai-gov -f
```

### Option 2: Direct Docker

```bash
git clone https://github.com/vspatabuga/ai-governance-orchestrator.git
cd ai-governance-orchestrator
./simulate.sh
```

## Access URLs

| Service | URL | Description |
|---------|-----|-------------|
| n8n Workflow | http://localhost:5678 | Automation workflow engine |
| Phoenix Dashboard | http://localhost:6006 | AI observability & tracing |
| Agent API | http://localhost:8000 | OpenClaw agent endpoint |

## Default Credentials

| Service | Username | Password |
|---------|----------|----------|
| n8n | admin@n8n.io | admin123 |

## Features

- **OpenClaw Agent** - Orchestrates AI workflows
- **Ollama** - Local LLM inference engine
- **LlamaIndex** - RAG context retrieval
- **Arize Phoenix** - AI tracing and evaluation
- **n8n** - Automation and integrations

## Components

### OpenClaw Agent
Central nervous system for AI orchestration. Manages agentic workflows and LLM interactions.

### Ollama
Local inference engine running models like DeepSeek-R1 and Qwen-2.5.

### LlamaIndex
Provides "Context Sovereignty" through local vector database for RAG.

### Arize Phoenix
Governance anchor that records traces, spans, and evaluation metrics.

### n8n
Integration layer connecting external systems with the AI governance stack.

## Stopping the Simulation

```bash
# Using vsp-porto
vsp-porto stop ai-gov

# Or using docker-compose
docker compose -p vsp-ai-gov down
```

## Troubleshooting

### Ollama is slow or out of memory

```bash
# Check Ollama logs
docker compose -p vsp-ai-gov logs ollama

# Use a smaller model
docker compose -p vsp-ai-gov exec openclaw_agent OLLAMA_MODEL=qwen2.5:3b
```

### Phoenix not capturing traces

```bash
# Check Phoenix connectivity
docker compose -p vsp-ai-gov logs phoenix

# Verify collector endpoint
curl http://localhost:6006/v1/traces
```

## Documentation

- [Architecture](./ARCHITECTURE.md)
- [Development Setup](./SETUP.md)
