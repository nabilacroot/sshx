# Base yang ringan
FROM debian:bookworm-slim

# Paket minimal yang dibutuhkan untuk install sshx (curl + ca-certificates)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install sshx (script resmi)
RUN curl -sSf https://sshx.io/get | sh

# Railway akan inject PORT (wajib ada proses yang listen jika kamu expose web)
# Tapi sshx biasanya tidak butuh HTTP server.
# Tetap set default PORT biar ga kosong
ENV PORT=8080

# Script start
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
