# Status do projeto

## 1. Seminário Evidence (Avaliação de Produto 2)

**O que já tá feito:**
- Slides montados (`Evidence BI_040235.pptx`, 7 slides)
- Dashboard Evidence funcionando em `my-dashboard/` (roda com `npm install` + `evidence dev`, sobe na porta 3000)
- Banco SQLite com 6 categorias de dados (aquisição, perda, ativos, dispositivos, tamanho do público, taxa de crescimento)
- Instruções de início no `EVIDENCE.md`
- Repositório conectado ao GitHub (`Kayo-Gabriel/Evidence`)

**O que falta:**
- [ ] Colocar prints da demonstração no slide 6 ("Evidence em uso") — o dashboard já roda, é só capturar
- [ ] (Opcional) Criar mais 1 ou 2 páginas de relatório usando as outras categorias do banco, pra deixar a demo mais completa
- [x] Enviar o .pptx no AVA
- [ ] Defesa oral (se for presencial)

---

## 2. Trabalho Prático — Power BI + AdventureWorks

**O que já tá feito:**
- Banco baixado: `AdventureWorks2025.bak` (50 MB)
- Script de setup pronto: `setup-database.ps1` na raiz (instala LocalDB, restaura o banco e exporta tudo pra CSV em `data-aw/`)

**O que falta (recaptulando):**
- [ ] Rodar o `setup-database.ps1` como admin
- [ ] Importar os CSVs de `data-aw/` no Power BI
- [ ] Montar o modelo em estrela (fato `FactResellerSales` + dimensões `DimProduct`, `DimDate`, `DimCustomer`, `DimReseller`, `DimGeography`, `DimProductCategory`)
- [ ] Criar os 10 KPIs em DAX (lista abaixo)
- [ ] Montar o dashboard (cards + gráfico de vendas por mês + top produtos + categoria + geografia + slicers)
- [ ] Fazer a apresentação de data storytelling (significado dos indicadores, insights, decisões)
- [x] Enviar o `.pbix` no AVA

### Os 10 KPIs (medidas DAX)

| # | KPI | DAX |
|---|-----|-----|
| 1 | Vendas | `SUM(FactResellerSales[SalesAmount])` |
| 2 | Unidades | `SUM(FactResellerSales[OrderQuantity])` |
| 3 | Custo | `SUM(FactResellerSales[TotalProductCost])` |
| 4 | Lucro | `Vendas - Custo` |
| 5 | Margem % | `DIVIDE(Lucro, Vendas, 0)` |
| 6 | Frete | `SUM(FactResellerSales[Freight])` |
| 7 | Ticket Médio | `DIVIDE(Vendas, Unidades, 0)` |
| 8 | Vendas YTD | `TOTALYTD(Vendas, DimDate[Date])` |
| 9 | Variação vs. Ano Anterior | `DIVIDE(Vendas - CALCULATE(Vendas, SAMEPERIODLASTYEAR(DimDate[Date])), CALCULATE(Vendas, SAMEPERIODLASTYEAR(DimDate[Date])), 0)` |
| 10 | Clientes Ativos | `DISTINCTCOUNT(FactResellerSales[CustomerKey])` |

> Bônus se sobrar tempo: Top Produto/Reseller (RANKX), Categorias com Vendas (DISTINCTCOUNT), Vendas por Dia (média móvel).

---

## Observações

- O `script.sqlite` na raiz é uma cópia antiga; o que o dashboard usa é `my-dashboard/sources/data_evidence_analitics/script.sqlite`.
- O `setup-database.ps1` ainda não foi totalmente testado (precisa de admin na execução). Se der erro no restore (nomes dos arquivos do backup), comunicar a falha + erro.
- Os logs (`dev.log`, `npm-*.log`, `sources.log`) e `.evidence/` não vão pro git (estão no `.gitignore`).

## Planejamento a partes

> Criar um docker para gerenciar a aplicação.