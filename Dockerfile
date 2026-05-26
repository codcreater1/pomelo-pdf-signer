# --- 1. AŞAMA: Frontend'i Derleme ---
FROM node:20-slim AS builder
WORKDIR /src

# Projenin kök dizindeki her şeyi kopyala
COPY . .

# package.json dosyasının nerede olduğunu bul, o klasöre gir ve derle
RUN TARGET_DIR=$(find . -name "package.json" -not -path "*/node_modules/*" | head -n 1 | xargs dirname) && \
    echo "Frontend dizini bulundu: $TARGET_DIR" && \
    cd "$TARGET_DIR" && \
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

# builder aşamasında üretilen dist klasörünü bul ve dinamik olarak kopyala
RUN mkdir -p frontend && \
    DIST_DIR=$(find /src -type d -name "dist" -not -path "*/node_modules/*" | head -n 1) && \
    if [ -n "$DIST_DIR" ]; then \
        cp -r "$DIST_DIR"/* ./frontend/; \
    fi

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
