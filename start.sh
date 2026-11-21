#!/bin/bash
set -e

# Enforce SSL for cloud PostgreSQL (Neon, Render, Supabase) if not explicitly set
export PGSSLMODE=${PGSSLMODE:-require}

echo "Starting Celery worker in the background..."
celery -A tasks worker --loglevel=info &

echo "Starting Streamlit on port ${PORT:-8501}..."
streamlit run app.py --server.port "${PORT:-8501}" --server.address 0.0.0.0
