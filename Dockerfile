# OpenClaw Gateway with Webhook Support
FROM node:22-alpine

WORKDIR /app

# Install OpenClaw globally
RUN npm install -g openclaw

# Create openclaw config directory
RUN mkdir -p /home/node/.openclaw

# Copy config files
COPY openclaw.json /home/node/.openclaw/openclaw.json

# Copy hooks.json if it exists, otherwise touch it
RUN if [ -f hooks.json ]; then \
      cp hooks.json /home/node/.openclaw/hooks.json; \
    else \
      echo '{}' > /home/node/.openclaw/hooks.json; \
    fi

# Set environment
ENV NODE_ENV=production
ENV OPENCLAW_GATEWAY_PORT=18789

# Expose gateway port
EXPOSE 18789

# Start gateway
CMD ["openclaw", "gateway", "--port", "18789", "--bind", "0.0.0.0"]
