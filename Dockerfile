FROM python:3.13-slim

RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir zensical \
    && pip install --no-cache-dir git+https://github.com/squidfunk/mike.git

WORKDIR /docs

EXPOSE 8000

CMD ["zensical", "serve", "--dev-addr", "0.0.0.0:8000"]
