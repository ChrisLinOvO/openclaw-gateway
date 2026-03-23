# OpenClaw Gateway - Render Deployment

## Prerequisites
- Render account
- GitHub repo with OpenClaw config

## Deployment Steps

### 1. Create GitHub Repository for OpenClaw Config

Create a new repo (e.g., `openclaw-config`) and push these files:
```
openclaw-config/
├── Dockerfile
├── openclaw.json
└── hooks.json (optional)
```

### 2. Deploy to Render

1. Log in to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"** (or connect from GitHub)
3. Connect your `openclaw-config` repo
4. Render will auto-detect `render.yaml`
5. Add environment variables:
   - `OPENCLAW_GATEWAY_TOKEN` = your gateway token
   - `GH_TOKEN` = ChrisLinOvO GitHub token
   - `GH_TOKEN_V2` = chvc727gg-sys GitHub token
   - `OPENCLAW_HOOKS_TOKEN` = (auto-generated if using render.yaml)

### 3. Get Public URL

After deploy, Render gives you a URL like:
```
https://openclaw-gateway.onrender.com
```

### 4. Create GitHub App

1. Go to `https://github.com/settings/apps` → **"New GitHub App"**
2. Set:
   - **Webhook URL**: `https://openclaw-gateway.onrender.com/hooks/github`
   - **Webhook secret**: (generate random string)
3. **Permissions**:
   - Repository permissions:
     - Pull requests: Read & Write
     - Issues: Read & Write
     - Contents: Read & Write
4. **Subscribe to events**: `Pull request`
5. Create and install the app to `ChrisLinOvO/milka-line-bot`

### 5. Add Webhook Secret to Render

In Render dashboard, add:
- `OPENCLAW_HOOKS_TOKEN` = your GitHub webhook secret

## Files Overview

| File | Purpose |
|------|---------|
| `Dockerfile` | Container image with OpenClaw |
| `openclaw.json` | Gateway config (no Discord/Line tokens needed on server) |
| `hooks.json` | Webhook routing configuration |
| `render.yaml` | Render Blueprint for auto-deploy |

## Webhook Flow

```
GitHub PR Event 
    ↓
GitHub App (webhook)
    ↓ POST /hooks/github
OpenClaw Gateway (Render)
    ↓
AI Agent (me) → Auto review + comment + merge
```

## Notes

- Render free tier: service sleeps after 15 min inactivity
- GitHub will retry failed webhooks
- First request after sleep may take 5-10s to wake
