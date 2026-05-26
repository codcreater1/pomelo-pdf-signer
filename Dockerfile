# --- 1. AŞAMA: Frontend Build (Node Çevresi) ---
FROM node:20-slim AS frontend-builder
WORKDIR /build-dir

# Repodaki her şeyi geçici olarak kopyalayalım
COPY . .

# Klasörün adının küçük/büyük harf olma ihtimaline karşı kontrol edip içeri giriyoruz,
# bağımlılıkları kurup build alıyoruz.
RUN if [ -d "frontend" ]; then cd frontend; else cd Frontend; fi && \
    npm install && \
    npm run build

# --- 2. AŞAMA: Python & FastAPI Environment ---
FROM python:3.12-slim
WORKDIR /app

# Sistem bağımlılıklarını yükle
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Python kütüphanelerini kur
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Tüm projeyi Python imajına kopyala
COPY . .

# İlk aşamada üretilen dist klasörünü, FastAPI'nin main.py'de beklediği tam konuma taşıyalım
# Eğer repoda klasörün adı büyük harfse ona göre, küçük harfse ona göre dist'i kopyalar.
RUN mkdir -p frontend && \
    if [ -d "/build-dir/frontend/dist" ]; then \
        cp -r /build-dir/frontend/dist ./frontend/; \
    else \
        cp -r /build-dir/Frontend/dist ./frontend/; \
    fi

EXPOSE 8000

# uvicorn başlama komutu (main.py modül olarak çağrılıyor)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
