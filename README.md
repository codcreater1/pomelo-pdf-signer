
<div align="center">

```
██████╗  ██████╗ ███╗   ███╗███████╗██╗      ██████╗
██╔══██╗██╔═══██╗████╗ ████║██╔════╝██║     ██╔═══██╗
██████╔╝██║   ██║██╔████╔██║█████╗  ██║     ██║   ██║
██╔═══╝ ██║   ██║██║╚██╔╝██║██╔══╝  ██║     ██║   ██║
██║     ╚██████╔╝██║ ╚═╝ ██║███████╗███████╗╚██████╔╝
╚═╝      ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝ ╚═════╝
                   PDF  S I G N E R
```

**Upload · Sign · Download — all in your browser.**

[![Python](https://img.shields.io/badge/Python-3.11+-3776ab?style=flat-square&logo=python&logoColor=white)](https://python.org)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.110+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PyMuPDF](https://img.shields.io/badge/PyMuPDF-1.24+-ff6f00?style=flat-square)](https://pymupdf.readthedocs.io)
[![License](https://img.shields.io/badge/License-MIT-6366f1?style=flat-square)](LICENSE)

</div>

---

## What is Pomelo PDF Signer?

A self-hosted PDF signing tool with a polished, dark-mode-first web interface. Upload any PDF, place your signature exactly where you want it, and download the result — no accounts, no cloud, no tracking.

Three ways to sign:

| Mode | How it works |
|------|-------------|
| 🎯 **Ready Sticker** | Pick from 8 pre-built stamps (Approved, Signed, Confidential, Urgent…) with live color + font controls |
| 🖼 **Custom Image** | Upload your own PNG or JPEG signature image |
| ✏️ **Draw** | Freehand draw directly in the browser with variable pen size and 5 ink colors |

---

## Screenshots

```
┌─────────────────────────────────────────────────────────────────┐
│  ████  PDF Signer          🌙 Dark / ☀️ Light toggle            │
├──────────┬──────────────────────────────────────────────────────┤
│          │                                                      │
│  👤 User │   ┌─ Step 1 ──┐  ┌─ Step 2 ──┐  ┌─ Step 3 ──┐     │
│  Profile │   │  Upload   │  │  Place    │  │  Download │     │
│          │   │  Files    │→ │  Signature│→ │  Signed   │     │
│ ─────── │   └───────────┘  └───────────┘  └───────────┘     │
│          │                                                      │
│ Signed   │   ┌─────────────────────────────────────────────┐   │
│ Documents│   │  🎯 Sticker  │  🖼 Image  │  ✏️ Draw         │   │
│          │   ├─────────────────────────────────────────────┤   │
│ 📄 doc1  │   │  ✅ Approved   📝 Signed   🔒 Confidential  │   │
│ 📄 doc2  │   │  📋 Draft      🚨 Urgent   📅 Date Stamp    │   │
│ 📄 doc3  │   └─────────────────────────────────────────────┘   │
│          │                                                      │
│ ─────── │   ┌─ PDF canvas ─────────────────────────────────┐  │
│ ☀️ Light  │   │                                              │  │
│ ⬅ Logout │   │  Click to place · Drag to reposition         │  │
└──────────┴───┴──────────────────────────────────────────────┴──┘
```

---

## Feature Highlights

### 🔐 Profile System
Each user creates a local profile (stored in browser `localStorage`) secured with a **4-digit PIN**. No backend auth required — it's completely client-side.

```
┌────────────────────────────────┐
│        PDF Signer              │
│                                │
│  ┌──────────────────────────┐  │
│  │  Select Profile          │  │
│  │                          │  │
│  │  🟣 Alice Chen           │  │
│  │     Product Designer  ›  │  │
│  │                          │  │
│  │  🟢 Bob Nakamura         │  │
│  │     Lead Engineer     ›  │  │
│  └──────────────────────────┘  │
│         ── or ──               │
│      + Create New Profile      │
└────────────────────────────────┘
          ↓ click profile
┌────────────────────────────────┐
│                                │
│          🟣  A                 │
│        Alice Chen              │
│      Enter your 4-digit PIN    │
│                                │
│      ⬤  ⬤  ○  ○              │
│                                │
│    1   2   3                   │
│    4   5   6                   │
│    7   8   9                   │
│  ←   0   ⌫                   │
└────────────────────────────────┘
```

### 🎨 Signature Editor
After uploading a PDF, a full editor opens with live controls:

```
┌─ Controls ──────┐  ┌─ PDF Canvas ────────────────────────────┐
│                 │  │                                          │
│  Font Style     │  │                                          │
│  [Dancing Scrpt]│  │     ┌─────────────────┐                 │
│                 │  │     │                 │                  │
│  Color          │  │     │   Your PDF      │                  │
│  ⚫ 🔵 🔴 🟢  │  │     │   content here  │                  │
│                 │  │     │                 │                  │
│  Width — 220px  │  │     └─────────────────┘                 │
│  ════════●═══   │  │                                          │
│                 │  │  ┌──────────────────────┐               │
│  ─────────────  │  │  │ ✅ APPROVED          │  ← draggable  │
│                 │  │  └──────────────────────┘               │
│  History        │  │                                          │
│  [↩ Undo][↪ Redo│  │  💡 Click to place · Drag to reposition │
│  [🗑 Clear All] │  │  ● Placed on page 1                     │
│                 │  └──────────────────────────────────────────┘
│  Pages  1/4     │
│  [‹ Prev][Next›]│
│                 │
│  [  ✍ Sign PDF ]│
└─────────────────┘
```

### 📂 Offline-First History
Every signed document is cached in **IndexedDB** — so re-downloading works even after the server restarts.

```
Sidebar history
│
├── 📄 contract_2024.pdf       May 26
├── 📄 invoice_Q1.pdf          May 25
└── 📄 nda_acme.pdf            May 24
         ↑
         click → re-downloads from local cache (no server needed)
```

---

## Architecture

```
                        Browser
  ┌─────────────────────────────────────────────────────┐
  │                                                     │
  │  index.html (single file, zero dependencies)        │
  │  ┌──────────────┐  ┌──────────────────────────┐    │
  │  │  Profile UI  │  │     Signature Editor     │    │
  │  │  localStorage│  │  pdf.js · Canvas API     │    │
  │  └──────────────┘  └──────────────────────────┘    │
  │           │                   │                     │
  │    ┌──────────────────────────────────┐             │
  │    │         IndexedDB Cache          │             │
  │    │  signed PDFs survive page reload │             │
  │    └──────────────────────────────────┘             │
  │                      │ fetch()                      │
  └──────────────────────┼──────────────────────────────┘
                         │  HTTP (multipart / JSON)
  ┌──────────────────────┼──────────────────────────────┐
  │  FastAPI  v2.0       │                              │
  │                      ▼                              │
  │   ┌─────────────────────────────────────────────┐  │
  │   │           routers/pdf.py                    │  │
  │   │  POST /upload  POST /sign  GET /download    │  │
  │   └────────────┬─────────────┬──────────────────┘  │
  │                │             │                      │
  │   ┌────────────▼──┐  ┌───────▼──────────────────┐  │
  │   │  FileService  │  │      PdfService           │  │
  │   │  stream +     │  │  PyMuPDF · PIL            │  │
  │   │  magic-byte   │  │  RGBA normalize           │  │
  │   │  validation   │  │  coordinate transform     │  │
  │   └────────────┬──┘  └───────┬──────────────────┘  │
  │                └──────┬──────┘                      │
  │           ┌───────────▼──────────────┐              │
  │           │     StorageService       │              │
  │           │  tmp/<task_id>/          │              │
  │           │  original.pdf            │              │
  │           │  signed.pdf              │              │
  │           │  auto-purge on startup   │              │
  │           └──────────────────────────┘              │
  └─────────────────────────────────────────────────────┘
```

### Request Flow

```
Client                          FastAPI                    Disk
  │                               │                         │
  │── POST /upload (PDF) ────────▶│                         │
  │                               │── stream to disk ──────▶│
  │                               │── magic-byte check      │
  │                               │── describe pages        │
  │◀── { task_id, pages[] } ──────│                         │
  │                               │                         │
  │── POST /sign ────────────────▶│                         │
  │   (task_id, page, x,y,w,h,    │── normalize image       │
  │    signature image)           │── embed via PyMuPDF     │
  │                               │── atomic save (.part→)─▶│
  │◀── { download_url } ──────────│                         │
  │                               │                         │
  │── GET /download/{task_id} ───▶│                         │
  │◀── signed.pdf (stream) ───────│◀── read ────────────────│
  │                               │── [background] cleanup  │
```

---

## Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| Backend framework | **FastAPI** | Async, typed, auto-docs |
| PDF engine | **PyMuPDF (fitz)** | Fast, reliable, preserves bookmarks |
| Image processing | **Pillow** | EXIF stripping, RGBA normalisation |
| Config | **pydantic-settings** | Env-var overrides, type validation |
| Frontend PDF render | **pdf.js 3.11** | In-browser PDF preview |
| Frontend storage | **IndexedDB** | Offline PDF cache |
| Frontend profiles | **localStorage** | Zero-backend auth |
| Containerisation | **Docker / Compose** | One-command deploy |

---

## Quick Start

### Option A — Local Python

```bash
# 1. Clone
git clone https://github.com/codcreater1/pomelo-pdf-signer.git
cd pomelo-pdf-signer

# 2. Install dependencies
pip install -r requirements.txt

# 3. Start the API
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# 4. Serve the frontend (separate terminal)
cd frontend
python -m http.server 3000
```

Open **http://localhost:3000** in your browser.

### Option B — Docker

```bash
git clone https://github.com/codcreater1/pomelo-pdf-signer.git
cd pomelo-pdf-signer
docker-compose up --build
```

API is at **http://localhost:8000** — serve `frontend/` with any static host.

---

## Configuration

All settings use the `PDFSIGN_` prefix and can be set via environment variables or a `.env` file:

```bash
# .env (gitignored)
PDFSIGN_MAX_PDF_BYTES=20971520      # 20 MB
PDFSIGN_MAX_IMAGE_BYTES=5242880     # 5 MB
PDFSIGN_TASK_TTL_SECONDS=7200       # 2 hours
PDFSIGN_CORS_ORIGINS=["https://myapp.com"]
PDFSIGN_API_SECRET_KEY=my-secret    # Bearer token (leave empty to disable)
PDFSIGN_STORAGE_ROOT=/data/tmp
```

| Variable | Default | Description |
|----------|---------|-------------|
| `PDFSIGN_MAX_PDF_BYTES` | `15728640` (15 MB) | Maximum PDF upload size |
| `PDFSIGN_MAX_IMAGE_BYTES` | `5242880` (5 MB) | Maximum signature image size |
| `PDFSIGN_STORAGE_ROOT` | `./tmp` | Working directory for task files |
| `PDFSIGN_TASK_TTL_SECONDS` | `3600` | Orphan task cleanup age at startup |
| `PDFSIGN_CORS_ORIGINS` | `["*"]` | Tighten in production |
| `PDFSIGN_API_SECRET_KEY` | `""` | Bearer auth (empty = disabled) |

---

## API Reference

Interactive docs are available at **http://localhost:8000/docs** once the server is running.

### `POST /api/v1/pdf/upload`

Upload a PDF. Returns a `task_id` and page geometry for coordinate conversion.

```
Request:  multipart/form-data
  file    — PDF file (max 15 MB)

Response 201:
{
  "task_id": "a3f8b2c...",
  "page_count": 3,
  "pages": [
    { "index": 0, "width": 595.28, "height": 841.89 },
    { "index": 1, "width": 595.28, "height": 841.89 },
    { "index": 2, "width": 595.28, "height": 841.89 }
  ],
  "upload_size_bytes": 204800
}
```

### `POST /api/v1/pdf/sign`

Embed a signature image at specific coordinates on a page.

```
Request:  multipart/form-data
  task_id — from /upload
  image   — PNG or JPEG (max 5 MB)
  page    — 0-indexed page number
  x       — top-left X in PDF points
  y       — top-left Y in PDF points
  w       — box width in PDF points
  h       — box height in PDF points

Response 200:
{
  "task_id": "a3f8b2c...",
  "page": 0,
  "download_url": "/api/v1/pdf/download/a3f8b2c..."
}
```

**Coordinate conversion** (pixel → PDF points):
```js
const x_pt = click_x / canvas_width  * page.width;
const y_pt = click_y / canvas_height * page.height;
```

### `GET /api/v1/pdf/download/{task_id}`

Stream the signed PDF. The task directory is deleted after the response is sent.

```
Response 200: application/pdf stream
Headers:
  Content-Disposition: attachment; filename="signed.pdf"
  Cache-Control: no-store, no-cache, must-revalidate
```

---

## Project Structure

```
pomelo-pdf-signer/
│
├── app/
│   ├── main.py                   FastAPI factory, CORS, lifespan hooks
│   │
│   ├── core/
│   │   ├── config.py             pydantic-settings (PDFSIGN_* env vars)
│   │   ├── exceptions.py         Domain exception hierarchy (AppError)
│   │   ├── models.py             Pydantic request / response schemas
│   │   └── validators.py         Magic-byte file-type predicates
│   │
│   ├── services/
│   │   ├── file_service.py       Async streaming upload + validation
│   │   ├── pdf_service.py        PyMuPDF: page inspection, signature embed
│   │   └── storage_service.py    Task directory lifecycle + TTL purge
│   │
│   └── routers/
│       └── pdf.py                HTTP: /upload, /sign, /download
│
├── frontend/
│   └── index.html                Single-file UI (zero build step)
│
├── tests/
│   ├── unit/
│   │   └── test_validators_and_exceptions.py
│   └── integration/
│       └── test_api.py           FastAPI TestClient, DI mocks
│
├── tmp/                          Gitignored task working directory
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── requirements-dev.txt
```

---

## Running Tests

```bash
pip install -r requirements-dev.txt

# All tests
pytest

# With coverage
pytest --cov=app --cov-report=term-missing

# Unit tests only
pytest tests/unit/

# Integration tests only
pytest tests/integration/
```

---

## Security Notes

- **Magic-byte validation** — uploaded files are validated by their actual bytes, not just the `Content-Type` header.
- **Image normalisation** — all signature images are decoded and re-encoded as RGBA PNG via Pillow before being passed to PyMuPDF. This strips EXIF metadata, ICC profiles, and defangs polyglot files.
- **Encrypted PDFs** — rejected at upload with a clear error message.
- **Coordinate bounds** — the backend enforces that the signature bounding box fits within the target page, with 0.5 pt float slack.
- **Atomic save** — signed PDFs are written to a `.part` file and renamed on success, so a crash mid-save cannot corrupt the output.
- **Task TTL** — orphaned task directories (e.g. from a server crash) are automatically purged on startup after `PDFSIGN_TASK_TTL_SECONDS`.
- **Optional bearer auth** — set `PDFSIGN_API_SECRET_KEY` to require `Authorization: Bearer <key>` on all API requests.

---

## License

[MIT](LICENSE) — use it, fork it, ship it.
