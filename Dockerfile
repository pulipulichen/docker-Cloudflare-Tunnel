FROM ubuntu:jammy

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O "/cloudflared" https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
RUN chmod +x /cloudflared

RUN apt-get install -y curl

ENV DELAY_SECONDS=10

COPY docker-build/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]