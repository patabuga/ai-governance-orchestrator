# 🤖 AI Governance Orchestrator

## 📌 Project Overview
**AI Governance Orchestrator** is a specialized engine designed to manage, audit, and secure private AI agents. It serves as the "Command Center" for local intelligence, ensuring that every AI decision is traced, evaluated, and compliant with sovereign security standards.

This repository focuses on the **Operational Orchestration** of tools like OpenClaw, Ollama, and Arize Phoenix within a unified environment.

---

## 🏗️ System Architecture

```mermaid
flowchart TD
    %% Global Styling
    classDef default fill:#f9f9f9,stroke:#333,stroke-width:1px,color:#333,font-family:Inter,sans-serif;
    classDef security fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef orchestrator fill:#ede7f6,stroke:#4527a0,stroke-width:2px;
    classDef intelligence fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px;
    classDef governance fill:#fff3e0,stroke:#e65100,stroke-width:2px,stroke-dasharray: 5 5;
    classDef infra fill:#eceff1,stroke:#455a64,stroke-width:1px;

    %% Nodes & Structure
    User((👤 User / Admin))
    
    subgraph PERIMETER [Zero-Trust Access Perimeter]
        direction LR
        TS[Tailscale Node] --- CF[Cloudflare Tunnel]
        GW[Reverse Proxy / Ingress]
    end

    subgraph CORE [Orchestration Layer]
        OC{{OpenClaw Engine}}
        N8N[n8n Automation]
    end

    subgraph BRAIN [Sovereign Intelligence]
        direction TB
        LI[LlamaIndex RAG] --- VDB[(Vector DB)]
        OL[Ollama LLM]
    end

    subgraph AUDIT [Governance & Observability]
        PHX[Arize Phoenix Dashboard]
    end

    %% Connections
    User ==>|Secure Access| GW
    GW ==> OC
    OC <==>|Event Trigger| N8N
    
    OC ==>|Context Query| LI
    OC ==>|Local Inference| OL
    
    %% Audit Trails (Dashed lines for clarity)
    OC -.->|Trace Data| PHX
    LI -.->|Eval Spans| PHX
    OL -.->|Token Logs| PHX
    
    %% Assign Classes
    class TS,CF,GW security;
    class OC,N8N orchestrator;
    class LI,VDB,OL intelligence;
    class PHX governance;
```

### 📋 Diagram Legend (Standard Architecture Mapping)
| Symbol/Style | Description | Classification (ISO/C4) |
| :--- | :--- | :--- |
| **Double Circle (( ))** | External Actor (User, Admin, or External Trigger) | **Person** |
| **Hexagon {{ }}** | Decision Engine / Logic Controller (OpenClaw) | **Component** |
| **Cylinder [( )]** | Data Persistence Layer (Vector Database) | **Container (Store)** |
| **Bold Line (==>)** | Primary Data Flow (Requests & Inference) | **Primary Relation** |
| **Dashed Line (-.->)** | Secondary Flow (Audit, Traces, Eval Metadata) | **Dependency / Trace** |
| **Blue Box** | Security & Access Management Layer | **Infrastructure** |
| **Purple Box** | Core System Orchestration | **Logic Layer** |
| **Green Box** | Local Intelligence & RAG System | **Intelligence Layer** |
| **Orange Box** | System Compliance & Observability | **Governance Layer** |

---

## 🚀 Key Components & Logic

### 1. The Brain: OpenClaw
Acts as the central nervous system. It manages agentic workflows, deciding when to search the local knowledge base or trigger an external automation. It ensures that LLM interactions follow predefined safety and logic bounds.

### 2. The Engine: Ollama
Provides the raw inference power using local models like **DeepSeek-R1** or **Qwen-2.5**. By running Ollama within the same network, we eliminate latency and data privacy risks associated with third-party APIs.

### 3. The Memory: LlamaIndex
Provides "Context Sovereignty." It indexes private documents (PDFs, Markdown, Wikis) into a local vector database. When a query is made, LlamaIndex injects only the relevant private context into the prompt, ensuring the LLM remains grounded in factual, private data.

### 4. The Auditor: Arize Phoenix
This is the "Governance" anchor. It records every trace, span, and retrieval step.
- **Audit:** Who asked what, and what context was retrieved?
- **Evaluation:** Did the LLM hallucinate? Was the retrieved context relevant?
- **Sovereignty:** Unlike SaaS alternatives, Phoenix runs locally, keeping the audit trail private.

### 5. The Connector: n8n
Handles the "External World" integration. It acts as the sensor and actuator, pulling data from GitHub, SQL databases, or internal APIs and feeding it into the OpenClaw orchestration loop.

---

## 🛡️ Governance Workflow

1.  **Request:** A user or an n8n trigger sends a request to OpenClaw.
2.  **Context Retrieval:** OpenClaw asks LlamaIndex for relevant private data.
3.  **Inference:** OpenClaw sends the prompt + context to Ollama.
4.  **Tracing:** Throughout the process, Arize Phoenix captures the metadata (Prompts, Token usage, Retrieval accuracy).
5.  **Validation:** Arize Phoenix runs automated Evals to ensure the response is safe and accurate before it is delivered.
6.  **Response:** The final, audited answer is sent back to the user/trigger.

---

## 🛠️ Tech Stack Employed

| Layer | Technologies |
| :--- | :--- |
| **Orchestration** | ![](https://img.shields.io/badge/OpenClaw-FF6D5A?style=flat&logo=openclaw&logoColor=white) ![](https://img.shields.io/badge/n8n-FF6D5A?style=flat&logo=n8n&logoColor=white) |
| **Intelligence** | ![](https://img.shields.io/badge/Ollama-000000?style=flat&logo=ollama&logoColor=white) ![](https://img.shields.io/badge/LlamaIndex-00A3E0?style=flat&logo=llamaindex&logoColor=white) |
| **Governance** | ![](https://img.shields.io/badge/Arize%20Phoenix-8D71BC?style=flat&logo=phoenix&logoColor=white) |
| **Infrastructure** | ![](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white) ![](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white) ![](https://img.shields.io/badge/Tailscale-4433FF?style=flat&logo=tailscale&logoColor=white) ![](https://img.shields.io/badge/WireGuard-881717?style=flat&logo=wireguard&logoColor=white) |
| **Security** | ![](https://img.shields.io/badge/Vaultwarden-175DDC?style=flat&logo=vaultwarden&logoColor=white) ![](https://img.shields.io/badge/Cloudflare-F38020?style=flat&logo=cloudflare&logoColor=white) |

---

## 🛠️ Simulation & Deployment
To instantly deploy and test the multi-node Zero-Trust AI architecture on your local machine, run our single-command simulation installer:

```bash
curl -sL https://raw.githubusercontent.com/patabuga/ai-governance-orchestrator/main/simulate.sh | bash
```

> **Note:** This requires Docker and Docker Compose to be installed on your system. It will safely orchestrate isolated virtual networks to demonstrate the sovereign infrastructure concept.

---
*Standardized by PES AI-Assistant (Gemini CLI)*
*Sovereign Infrastructure Compliance v1.0*
