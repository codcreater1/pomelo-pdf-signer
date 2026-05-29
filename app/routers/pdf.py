from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse

from app.services.storage_service import storage_service
from app.services.token_service import verify_download_token

router = APIRouter()


@router.get("/download")
def download(task_id: str, token: str):
    try:
        verified_task = verify_download_token(token)
    except Exception:
        raise HTTPException(status_code=403, detail="Invalid or expired token")

    if verified_task != task_id:
        raise HTTPException(status_code=403, detail="Task mismatch")

    file_path = storage_service.signed_path(task_id)

    return FileResponse(
        path=file_path,
        media_type="application/pdf",
        filename="signed.pdf"
    )
