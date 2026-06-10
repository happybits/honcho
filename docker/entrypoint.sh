#!/bin/sh
set -e

echo "Running database migrations..."
/app/.venv/bin/python scripts/provision_db.py

echo "Aligning pgvector dims with EMBEDDING_VECTOR_DIMENSIONS (no-op when matching)..."
/app/.venv/bin/python scripts/configure_embeddings.py --yes

echo "Starting API server..."
exec /app/.venv/bin/fastapi run --host :: src/main.py
