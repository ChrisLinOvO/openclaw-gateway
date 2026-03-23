# OpenClaw Gateway with Webhook Support
FROM node:22-alpine

WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw

# Create openclaw config directory and set HOME
ENV HOME=/root
ENV OPENCLAW_CONFIG_DIR=/root/.openclaw

# Copy config files
COPY openclaw.json ${OPENCLAW_CONFIG_DIR}/openclaw.json

# Copy hooks.json if it exists
RUN if [ -f hooks.json ]; then \
      cp hooks.json ${OPENCLAW_CONFIG_DIR}/hooks.json; \
    fi

# Set environment
ENV NODE_ENV=production
ENV OPENCLAW_GATEWAY_PORT=18789
ENV OLLAMA_API_KEY=ollama-local

# Expose gateway port
EXPOSE 18789

# Start gateway with explicit config
CMD ["openclaw", "gateway", "--port", "18789", "--bind", "lan", "--allow-unconfigured"]
