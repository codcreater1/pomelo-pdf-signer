# --- 1. AŞAMA: Frontend'i Derleme ---
FROM node:20-slim AS builder
WORKDIR /src

# Projenin kök dizindeki her şeyi kopyala
COPY . .

# Klasör adı Frontend veya frontend olsa da yakala, bağımlılıkları kur ve derle
RUN if [ -d "frontend" ]; then cd frontend; else cd Frontend; fi && \
    npm install && \
    npm run build

# --- 2. AŞAMA: Runtime (Çalışma) İmajı ---
FROM python:3.12-slim
WORKDIR /app

# Sistem gereksinimleri
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Backend bağımlılıkları
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Kök dizindeki backend kodlarını kopyala
COPY . .

# Üst aşamada (builder) derlenen dist klasörünü bul ve /app/frontend/dist içine kopyala
COPY --from=builder /src/frontend/dist ./frontend/dist
COPY --from=builder /src/Frontend/dist ./frontend/dist

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
