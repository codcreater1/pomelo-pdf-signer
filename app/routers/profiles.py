"""Profile management API endpoints."""

from __future__ import annotations

import hashlib
import os
import uuid
from typing import Any

from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel
import asyncpg

router = APIRouter(prefix="/profiles", tags=["profiles"])

DATABASE_URL = os.getenv("DATABASE_URL")


async def get_conn():
    return await asyncpg.connect(DATABASE_URL)


# ── Schemas ──────────────────────────────────────────────────────────────────

class ProfileCreate(BaseModel):
    name: str
    title: str
    color: str
    pin: str


class ProfileResponse(BaseModel):
    id: str
    name: str
    title: str
    color: str


class PinVerify(BaseModel):
    profile_id: str
    pin: str


# ── Helpers ──────────────────────────────────────────────────────────────────

def hash_pin(pin: str) -> str:
    return hashlib.sha256(pin.encode()).hexdigest()


# ── Endpoints ────────────────────────────────────────────────────────────────

@router.get("/", response_model=list[ProfileResponse])
async def list_profiles():
    conn = await get_conn()
    try:
        rows = await conn.fetch("SELECT id, name, title, color FROM profiles ORDER BY created_at")
        return [dict(r) for r in rows]
    finally:
        await conn.close()


@router.post("/", response_model=ProfileResponse, status_code=status.HTTP_201_CREATED)
async def create_profile(body: ProfileCreate):
    if not body.pin.isdigit() or len(body.pin) != 4:
        raise HTTPException(400, "PIN must be exactly 4 digits.")
    conn = await get_conn()
    try:
        profile_id = uuid.uuid4().hex
        await conn.execute(
            "INSERT INTO profiles (id, name, title, color, pin_hash) VALUES ($1,$2,$3,$4,$5)",
            profile_id, body.name, body.title, body.color, hash_pin(body.pin)
        )
        return {"id": profile_id, "name": body.name, "title": body.title, "color": body.color}
    finally:
        await conn.close()


@router.post("/verify", response_model=ProfileResponse)
async def verify_pin(body: PinVerify):
    conn = await get_conn()
    try:
        row = await conn.fetchrow(
            "SELECT id, name, title, color, pin_hash FROM profiles WHERE id=$1",
            body.profile_id
        )
        if not row or row["pin_hash"] != hash_pin(body.pin):
            raise HTTPException(401, "Incorrect PIN.")
        return {"id": row["id"], "name": row["name"], "title": row["title"], "color": row["color"]}
    finally:
        await conn.close()
