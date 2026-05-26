# --- 1. AŞAMA: Frontend'i derleme (Build Stage) ---
FROM node:20-slim AS frontend-builder
WORKDIR /frontend-build
# Sadece frontend klasörünü içeri al
COPY frontend/package*.json ./
# Hata veren 'npm ci' yerine 'npm install' kullanıyoruz
RUN npm install
COPY frontend/ ./
RUN npm run build

# --- 2. AŞAMA: Python ve FastAPI'yi ayağa kaldırma ---
FROM python:3.12-slim
WORKDIR /app

# Sistem için gerekli paketleri kur
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Backend kodlarını kopyala
COPY . .

# İlk aşamada üretilen dist klasörünü FastAPI'nin okuyacağı yere kopyala
COPY --from=frontend-builder /frontend-build/dist ./frontend/dist

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
