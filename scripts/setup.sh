#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}DesignSync AI - Setup Wizard${NC}"

require() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo -e "${RED}Error: Missing required command: '$1'. Please install it and try again.${NC}"; exit 1
  fi
}

# Prereqs
for bin in node pnpm git; do require "$bin"; done
NODE_MAJOR=$(node -p "process.versions.node.split('.') [0]")
if [ "$NODE_MAJOR" -lt 18 ]; then echo -e "${RED}Node.js >= 18 required${NC}"; exit 1; fi

echo -e "${YELLOW}Configuring git remote...${NC}"
REPO_URL="https://github.com/wtfisai/6agents.git"
if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "chore: initial scaffold" || true
  git branch -M main
  git remote add origin "$REPO_URL" || true
fi

echo -e "${YELLOW}Creating .env from template...${NC}"
if [ -f .env ]; then mv .env .env.backup; echo -e "${YELLOW}Backed up existing .env to .env.backup${NC}"; fi
cp .env.example .env

prompt_for_env() {
  local var_name="$1"
  local prompt_text="$2"
  local current_val
  current_val=$(grep "^${var_name}=" .env | head -n 1 | cut -d '=' -f2-)

  if [[ "$current_val" == "prompt_for_input" ]]; then
    read -p "$(echo -e "${YELLOW}Enter ${prompt_text} (${var_name}): ${NC}")" new_val
    if [[ -n "$new_val" ]]; then
      # Use # as a delimiter and -i.bak for cross-platform (macOS/Linux) compatibility.
      sed -i.bak "s#^${var_name}=.*#${var_name}=${new_val}#" .env && rm .env.bak
    fi
  fi
}

echo -e "${YELLOW}Configuring essential .env variables... (Press Enter to skip and fill in manually later)${NC}"
prompt_for_env "FIREBASE_PROJECT_ID" "your Firebase Project ID"
prompt_for_env "GEMINI_API_KEY" "your Google Gemini API Key"
prompt_for_env "FIGMA_PERSONAL_ACCESS_TOKEN" "your Figma Personal Access Token"

echo -e "${YELLOW}Installing dependencies (pnpm)...${NC}"
pnpm install

echo -e "${GREEN}Setup complete. Next steps:${NC}"
cat <<EOF
1) Edit .env with your real credentials
2) Run web: pnpm dev:web
3) Run api: pnpm dev:api
EOF
