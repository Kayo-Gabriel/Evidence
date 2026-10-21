# Status do projeto

Seminário técnico — Avaliação de Produto 2 (2º bimestre)
Tema do grupo: **Evidence** (item 10 da lista)
Prazo: 18/11/2026 · Vale 15 pontos · Grupo de 4 (Kayo, Ruan, Gabriel, Pedro)

## O que já tá feito

- Slides montados (`Evidence BI_040235.pptx`, 7 slides)
- Dashboard Evidence funcionando em `my-dashboard/` — **corrigido em 21/10** (o config estava quebrado; detalhes na seção "Observações")
- Banco SQLite com 6 categorias de dados (aquisição, perda, ativos, dispositivos, tamanho do público, taxa de crescimento) — 153 linhas na tabela `data_evidence_analitics`
- Página de relatório testada e renderizando: "Usuários ativos por mês" (gráfico de barras por categoria)
- Instruções de início no `EVIDENCE.md`
- Repositório conectado ao GitHub (`Kayo-Gabriel/Evidence`)
- [x] .pptx enviado no AVA

## O que falta

- [ ] **Commitar a correção do `evidence.config.yaml` no GitHub** (o repo ainda tem o formato antigo 0.10.2, que não sobe no Evidence 40)
- [ ] Colocar prints da demonstração no slide 6 ("Evidence em uso") — o dashboard já roda, é só capturar
- [ ] (Opcional) Criar mais 1 ou 2 páginas de relatório usando as outras categorias do banco (dispositivos, tamanho do público, taxa de crescimento), pra deixar a demo mais completa
- [ ] Gravar o vídeo da apresentação (7–20 min) e subir no YouTube — **obrigatório se for EAD/semi-presencial**
- [ ] Defesa oral (se for presencial)

## Checklist do seminário (o que o enunciado pede x o que os slides têm)

| Exigido | Onde está |
|---|---|
| Contextualização do problema | slide 4 ("O caos do arrasta e solta...") |
| Conceitos fundamentais | slide 2 (BI as Code, Markdown + SQL) |
| Arquitetura básica | slide 3 (BD → parquet → Svelte → DuckDB Wasm) |
| Demonstração prática | slide 6 + dashboard rodando |
| Vantagens e limitações | slide 5 (forças x fraquezas) |
| Exemplos práticos de uso | ⚠️ fraco — só 1 página de relatório, dá pra reforçar com as outras categorias do banco |

## Como rodar o dashboard (pra gravação/demo)

```
cd my-dashboard
npm install
npx evidence sources   # avalia o banco SQLite e gera os dados (rodar de novo se o .sqlite mudar)
npx evidence dev
```

Sobe em `http://localhost:3000` — a página "Usuarios Ativos Por Mês" é a demo.

## Observações

- **O dashboard estava quebrado e foi corrigido localmente (21/10/2026):** o `evidence.config.yaml` estava no formato antigo (0.10.2), mas o Evidence 40.1.8 instalado localmente exige o formato novo com `plugins`. Erro ao rodar: `Invalid evidence.config.yaml file: plugins: Required`. Correção aplicada:
  - `my-dashboard/evidence.config.yaml` → adicionada a seção `plugins` (componente `@evidence-dev/core-components` + datasource `@evidence-dev/sqlite`)
  - `my-dashboard/sources/data_evidence_analitics/data_evidence_analitics.sql` → arquivo novo com `select * from data_evidence_analitics`. No Evidence 40 o conector SQLite é *file-based*: cada `.sql` na pasta do source vira uma tabela; sem ele o source não expõe nada e a query da página falhava com `Catalog Error: Table ... does not exist`
  - **Falta commitar essas 2 mudanças no GitHub** — quem clonar o repo hoje ainda encontra o config quebrado
- O `script.sqlite` na raiz é uma cópia idêntica à do dashboard (153 linhas) e nem está no git (untracked); o que o dashboard usa é `my-dashboard/sources/data_evidence_analitics/script.sqlite`
- Não existe `.gitignore` na raiz do repo. O `my-dashboard/.gitignore` ignora só `.evidence/`, `connection.yaml` e `node_modules` (nenhum log existe no momento)
- O `EVIDENCE.md` documenta o fluxo antigo (só `npm install` + `evidence dev`); o passo `evidence sources` é obrigatório no Evidence 40

## Planejamento a partes

> Criar um docker para gerenciar a aplicação.
