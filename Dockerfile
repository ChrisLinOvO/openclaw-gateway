# OpenClaw Gateway with Webhook Support
FROM node:22-alpine

WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw

# Create openclaw config directory and set HOME
ENV HOME=/root
ENV OPENCLAW_CONFIG_DIR=/root/.openclaw
ENV OLLAMA_API_KEY=ollama-local

# Copy config files
COPY openclaw.json ${OPENCLAW_CONFIG_DIR}/openclaw.json

# Copy hooks.json if it exists
RUN if [ -f hooks.json ]; then \
      cp hooks.json ${OPENCLAW_CONFIG_DIR}/hooks.json; \
    fi

# Expose PORT from environment
EXPOSE ${PORT}

# Start gateway - use PORT env var directly
CMD ["sh", "-c", "openclaw gateway --port $PORT --bind lan --allow-unconfigured"]
