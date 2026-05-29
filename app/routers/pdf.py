from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse
import logging

from app.services.storage_service import storage_service
from app.services.token_service import verify_download_token

router = APIRouter()
logger = logging.getLogger(__name__)


@router.get("/download")
def download(task_id: str, token: str):
    # 1) Token validation
    try:
        verified_task = verify_download_token(token)
    except ValueError:
        raise HTTPException(status_code=403, detail="Invalid or expired token")
    except Exception:
        logger.exception("Token service error")
        raise HTTPException(status_code=500, detail="Token verification failed")

    # 2) Task mismatch check
    if verified_task != task_id:
        logger.warning(f"Task mismatch attempt: {task_id}")
        raise HTTPException(status_code=403, detail="Task mismatch")

    # 3) Resolve file path
    file_path = storage_service.signed_path(task_id)

    # 4) File existence check
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="Signed PDF not found")

    # 5) Return file
    return FileResponse(
        path=file_path,
        media_type="application/pdf",
        filename="signed.pdf"
    )
