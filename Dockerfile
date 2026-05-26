# --- 1. AŞAMA: Frontend Build (Node.js) ---
FROM node:20-slim AS frontend-builder
WORKDIR /build-dir

# Repodaki her şeyi kopyala (Klasör adı büyük de olsa küçük de olsa yakalamak için)
COPY . .

# Klasörün adını kontrol et, içine gir, package.json'ı bul ve derle
RUN if [ -d "frontend" ]; then cd frontend; else cd Frontend; fi && \
    npm install && \
    npm run build

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

# Üretilen dist klasörünü, klasör adına bakmaksızın /app/frontend/dist içine taşıyalım
RUN mkdir -p frontend && \
    if [ -d "/build-dir/frontend/dist" ]; then \
        cp -r /build-dir/frontend/dist/* ./frontend/; \
    else \
        cp -r /build-dir/Frontend/dist/* ./frontend/; \
    fi

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
