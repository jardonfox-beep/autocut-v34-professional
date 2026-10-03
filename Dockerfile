FROM node:22-bookworm-slim

ENV NODE_ENV=production
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    fonts-dejavu \
    fontconfig \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY backend/package*.json /app/backend/
RUN cd /app/backend && npm install --omit=dev

COPY backend /app/backend
COPY frontend /app/frontend

RUN mkdir -p /app/backend/data/projects /app/backend/data/uploads /app/backend/data/outputs

WORKDIR /app/backend
EXPOSE 10000
CMD ["node","src/server.js"]
