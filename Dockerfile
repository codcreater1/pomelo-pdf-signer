# --- 1. AŞAMA: Frontend Build (Node.js) ---
FROM node:20-slim AS frontend-builder
WORKDIR /frontend

# Sadece frontend bağımlılıklarını ve kodlarını kopyalayalım
COPY frontend/package*.json ./
RUN npm install

COPY frontend/ ./
RUN npm run build

# --- 2. AŞAMA: Runtime Image (Python & FastAPI) ---
FROM python:3.12-slim
WORKDIR /app

# Sistem bağımlılıklarını kur
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Backend bağımlılıklarını kur
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Tüm backend kodlarını kopyala
COPY . .

# İlk aşamada üretilen 'dist' klasörünü doğrudan runtime imajına kopyala
COPY --from=frontend-builder /frontend/dist ./frontend/dist

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
