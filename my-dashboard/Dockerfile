# Imagem do dashboard Evidence — roda igual em Windows, Linux e macOS
FROM node:22-bookworm-slim

# Toolchain para compilar o sqlite3 caso nao exista binario pronto para a plataforma
RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 make g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json .npmrc ./
RUN npm ci

COPY . .

EXPOSE 3000

# Avalia o banco SQLite a cada start e sobe o servidor
CMD ["sh", "-c", "npx evidence sources && npx evidence dev -- --host 0.0.0.0 --port 3000 --open false"]
