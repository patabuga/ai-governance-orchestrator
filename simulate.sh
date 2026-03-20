#!/usr/bin/env bash

# ==============================================================================
# 🤖 VSP AI Governance Orchestrator - Local Simulation Installer
# ==============================================================================
# This script simulates a multi-node, zero-trust AI governance environment.
# It uses Docker Compose to spin up isolated networks representing a sovereign
# infrastructure, deploying OpenClaw, Ollama, and Arize Phoenix.
# ==============================================================================

set -e # Exit on error

# --- Styling ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
cat << "EOF"
 _   _  _____  ____   ___  _____   __  ___  
| | | |/ ___/ |  _ \ / _ \|_   _| / / / _ \ 
| | | |\___ \ | |_) | | | | | |  / / | | | |
| |_| | ___) ||  __/| |_| | | | / /  | |_| |
 \___/ |____/ |_|    \___/  |_|/_/    \___/ 

  SOVEREIGN AI GOVERNANCE SIMULATION
EOF
echo -e "${NC}"

echo -e "${YELLOW}[1/4] Checking system requirements...${NC}"
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed. Please install Docker first.${NC}"
    exit 1
fi
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo -e "${RED}Error: Docker Compose is not installed.${NC}"
    exit 1
fi
echo -e "${GREEN}✔ Docker and Docker Compose found.${NC}"

# Define workspace
SIM_DIR="/tmp/vsp-ai-simulation"
echo -e "\n${YELLOW}[2/4] Setting up simulation environment in ${SIM_DIR}...${NC}"
mkdir -p "$SIM_DIR"
cd "$SIM_DIR"

# Download the Compose file (Simulated for now, would be a real URL in production)
echo -e "Downloading topology configuration..."
cat << 'EOF' > docker-compose.yml
version: '3.8'

# --- Network Engineering (Simulating Zero-Trust / Multi-Cloud) ---
networks:
  oci_cloud_net:
    internal: true # Simulated closed network (No internet access)
  azure_cloud_net:
    internal: true # Simulated closed network
  zero_trust_tunnel:
    driver: bridge # The encrypted bridge (Simulating Tailscale/WireGuard)

services:
  # --- Node A: The Intelligence Engine (Oracle Cloud Simulation) ---
  ollama:
    image: ollama/ollama:latest
    container_name: vsp_sim_ollama
    networks:
      - oci_cloud_net
      - zero_trust_tunnel
    volumes:
      - ollama_data:/root/.ollama

  # --- Node B: The Governance Orchestrator (Azure Simulation) ---
  phoenix:
    image: arizeai/phoenix:latest
    container_name: vsp_sim_phoenix
    ports:
      - "6006:6006" # Only Phoenix Dashboard is exposed to host
    networks:
      - azure_cloud_net
      - zero_trust_tunnel

volumes:
  ollama_data:
EOF

echo -e "\n${YELLOW}[3/4] Orchestrating Sovereign Infrastructure...${NC}"
# Use docker-compose or docker compose depending on what's installed
if command -v docker-compose &> /dev/null; then
    docker-compose up -d
else
    docker compose up -d
fi

echo -e "\n${GREEN}[4/4] ✔ Simulation Successfully Deployed!${NC}"
echo -e "======================================================================"
echo -e "🧠 The AI Governance Stack is now running in isolated virtual networks."
echo -e "📊 Access the ${BLUE}Arize Phoenix Audit Dashboard${NC} at: http://localhost:6006"
echo -e "🛑 To stop the simulation, run: 'cd $SIM_DIR && docker-compose down'"
echo -e "======================================================================"
