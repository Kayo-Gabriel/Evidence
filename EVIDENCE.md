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
