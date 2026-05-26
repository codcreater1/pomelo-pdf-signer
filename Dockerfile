# --- 1. AŞAMA: Frontend'i derleme (Build Stage) ---
FROM node:20-slim AS frontend-builder
WORKDIR /frontend-build

# Tüm projeyi kopyalayalım ki frontend klasörü nerede olursa olsun bulabilsin
COPY . .

# Frontend klasörünün içine girip bağımlılıkları kuralım ve build edelim
# (Klasör ismi büyük harfle başlasa bile otomatik eşleşir)
RUN cd [fF]rontend && npm install && npm run build

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

# Tüm backend kodlarını kopyala
COPY . .

# İlk aşamada oluşan dist klasörünü FastAPI'nin okuyacağı yere çekelim
COPY --from=frontend-builder /frontend-build/frontend/dist ./frontend/dist

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
