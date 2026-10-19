# Status do projeto

Seminário técnico — Avaliação de Produto 2 (2º bimestre)
Tema do grupo: **Evidence** (item 10 da lista)
Prazo: 18/11/2026 · Vale 15 pontos · Grupo de 4 (Kayo, Ruan, Gabriel, Pedro)

## O que já tá feito

- Slides montados (`Evidence BI_040235.pptx`, 7 slides)
- Dashboard Evidence funcionando em `my-dashboard/` (roda com `npm install` + `evidence dev`, sobe na porta 3000)
- Banco SQLite com 6 categorias de dados (aquisição, perda, ativos, dispositivos, tamanho do público, taxa de crescimento)
- Página de relatório pronta: "Usuários ativos por mês" (gráfico de barras por categoria)
- Instruções de início no `EVIDENCE.md`
- Repositório conectado ao GitHub (`Kayo-Gabriel/Evidence`)
- [x] .pptx enviado no AVA

## O que falta

- [ ] Colocar prints da demonstração no slide 6 ("Evidence em uso") — o dashboard já roda, é só capturar
- [ ] (Opcional) Criar mais 1 ou 2 páginas de relatório usando as outras categorias do banco, pra deixar a demo mais completa
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
npm install --legacy-peer-deps
npx evidence dev
```

Sobe em `http://localhost:3000` — a página "Usuarios Ativos Por Mês" é a demo.

## Observações

- O `script.sqlite` na raiz é uma cópia antiga; o que o dashboard usa é `my-dashboard/sources/data_evidence_analitics/script.sqlite`
- Os logs (`dev.log`, `npm-*.log`, `sources.log`) e `.evidence/` não vão pro git (estão no `.gitignore`)
- O `evidence.config.yaml` do GitHub é o formato antigo (0.10.2); com o Evidence 40 instalado localmente ele precisa do formato novo (plugins/datasources) pra subir — vale atualizar no repo

## Planejamento a partes

> Criar um docker para gerenciar a aplicação.
