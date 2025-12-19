#!/bin/bash
set -e

echo "Generating config.toml from environment variables..."

# Method 1: Using envsubst (simple variable substitution)
envsubst < /home/perplexica/config.toml.template > /home/perplexica/config.toml

# Method 2: Alternative - Generate config directly with heredoc
# Uncomment below and remove Method 1 if you prefer this approach
# cat > /home/perplexica/config. toml << EOF
# [GENERAL]
# PORT = ${PORT:-3000}
# SIMILARITY_MEASURE = "cosine"
# 
# [API_KEYS]
# OPENAI = "${OPENAI_API_KEY:-}"
# GROQ = "${GROQ_API_KEY:-}"
# ANTHROPIC = "${ANTHROPIC_API_KEY:-}"
# 
# [API_ENDPOINTS]
# SEARXNG = "${SEARXNG_API_URL:-http://127.0.0.1:8080}"
# OLLAMA = "${OLLAMA_API_URL:-}"
# EOF

echo "config.toml generated successfully"

# Run database migrations
echo "Running database migrations..."
node /home/perplexica/migrate.js

# Set default PORT if not provided by Railway
export PORT=${PORT:-3000}

echo "Starting services..."
echo "SearXNG will be available internally at http://127.0.0.1:8080"
echo "Perplexica will be available at port $PORT"

# Start supervisord (manages both processes)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf