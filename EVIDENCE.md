# Inicializar o projeto

### Primeira vez inicializando o projeto

**Windows (PowerShell):**
```
cd my-dashboard
npm install
irm https://evidence.studio/install.ps1 | iex
```

**Linux (Fedora/Ubuntu) e macOS:**
```
cd my-dashboard
npm install
curl -fsSL https://evidence.studio/install.sh | sh
```
> Se o `npm install` falhar na dependência `sqlite3` (compilação nativa),
> instale a toolchain antes: `sudo dnf install python3 make gcc` (Fedora)
> ou `sudo apt install build-essential python3` (Debian/Ubuntu).

### Iniciar o serviço
```
evidence sources   # avalia o banco SQLite e gera os dados (rodar de novo se o .sqlite mudar)
evidence dev
```

O serviço deve iniciar na porta 3000 ou melhor: http://localhost:3000

# Rodar com Docker (qualquer sistema)

Não precisa de Node nem de toolchain instalados, só do Docker. Na raiz do repositório:
```
docker compose up --build
```

Abre em http://localhost:3000. O container roda `evidence sources` e `evidence dev` sozinho a cada start.

- As pastas `my-dashboard/pages` e `my-dashboard/sources` são montadas no container: editar uma página atualiza o navegador na hora.
- Se o `.sqlite` mudar, reinicie o container (`docker compose restart`) para reavaliar os dados.
- Para parar: `Ctrl+C` ou `docker compose down`.

> As versões do Evidence estão fixadas no `package.json` (40.1.8) para o Docker
> instalar exatamente o que foi testado. Não troque por `latest`.
