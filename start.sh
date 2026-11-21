#!/bin/bash
set -e

# Enforce SSL for cloud PostgreSQL (Neon, Render, Supabase) if not explicitly set
export PGSSLMODE=${PGSSLMODE:-require}

# Force Linux glibc to release freed heap memory back to the OS immediately
export MALLOC_TRIM_THRESHOLD_=65536
export PYTHONUNBUFFERED=1

echo "Starting Celery worker in the background..."
celery -A tasks worker --pool=solo --loglevel=info &

echo "Starting Streamlit on port ${PORT:-8501}..."
streamlit run app.py --server.port "${PORT:-8501}" --server.address 0.0.0.0 --server.headless true --server.fileWatcherType none --browser.gatherUsageStats false
