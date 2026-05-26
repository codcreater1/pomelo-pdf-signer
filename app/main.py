"""FastAPI application factory."""

from __future__ import annotations

import logging
from contextlib import asynccontextmanager
from pathlib import Path
from typing import AsyncIterator

from fastapi import FastAPI, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse, JSONResponse
from fastapi.staticfiles import StaticFiles

from app.core.config import settings
from app.core.exceptions import AppError
from app.core.models import ErrorResponse
from app.routers import pdf as pdf_router
from app.services.storage_service import storage_service

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s  %(levelname)-8s  %(name)s — %(message)s",
    datefmt="%Y-%m-%dT%H:%M:%S",
)
logger = logging.getLogger("pdfsign")


@asynccontextmanager
async def lifespan(_app: FastAPI) -> AsyncIterator[None]:
    removed = storage_service.purge_stale(settings.task_ttl_seconds)
    if removed:
        logger.info("Startup: purged %d stale task director(ies).", removed)
    else:
        logger.info("Startup: no stale task directories found.")
    yield
    logger.info("Shutdown: exiting cleanly.")


def create_app() -> FastAPI:
    app = FastAPI(
        title=settings.app_title,
        version=settings.app_version,
        description=(
            "Upload a PDF, place a visual signature at precise coordinates, "
            "and download the signed file — all via a clean REST API."
        ),
        lifespan=lifespan,
        redirect_slashes=False,
    )

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_credentials=False,
        allow_methods=["GET", "POST", "OPTIONS"],
        allow_headers=["Content-Type", "Authorization"],
        expose_headers=["Content-Disposition"],
    )

    @app.exception_handler(AppError)
    async def _app_error_handler(request: Request, exc: AppError) -> JSONResponse:
        logger.warning(
            "Domain error on %s %s: [%s] %s",
            request.method, request.url.path,
            type(exc).__name__, exc.detail,
        )
        return JSONResponse(
            status_code=exc.http_status,
            content=ErrorResponse(detail=exc.detail).model_dump(),
        )

    @app.exception_handler(Exception)
    async def _unhandled_error_handler(request: Request, exc: Exception) -> JSONResponse:
        logger.exception("Unhandled exception on %s %s", request.method, request.url.path)
        return JSONResponse(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            content=ErrorResponse(detail="Internal server error.").model_dump(),
        )

    # Routers
    app.include_router(pdf_router.router, prefix=settings.api_prefix)

    # Meta endpoints
    @app.get("/healthz", tags=["meta"], summary="Liveness probe.")
    async def healthz() -> dict[str, str]:
        return {"status": "ok", "version": settings.app_version}

    @app.get("/readyz", tags=["meta"], summary="Readiness probe.")
    async def readyz() -> dict[str, str]:
        try:
            probe = settings.storage_root / ".readyz"
            probe.touch()
            probe.unlink()
        except OSError as exc:
            return JSONResponse(
                status_code=503,
                content={"status": "error", "detail": str(exc)},
            )
        return {"status": "ok", "storage": str(settings.storage_root)}

    # Frontend — static files
    frontend_path = Path(__file__).resolve().parent.parent / "frontend"
    if frontend_path.exists():
        app.mount(
            "/static",
            StaticFiles(directory=str(frontend_path)),
            name="static",
        )

    @app.get("/", include_in_schema=False)
    async def root():
        index = frontend_path / "index.html"
        if index.exists():
            return FileResponse(str(index))
        return {"status": "running", "message": "Frontend not found."}

    return app


app = create_app()
