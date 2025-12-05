FROM debian:trixie-slim

ARG app_version

ENV DEBIAN_FRONTEND=noninteractive

# Install curl, jq, and certificates, then clean up apt cache.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        jq \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for better security.
RUN useradd -m -u 1000 -s /bin/bash curluser

# Copy entrypoint script.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Ensure entrypoint is executable.
RUN chmod +x /usr/local/bin/entrypoint.sh

USER curluser

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--help"]
