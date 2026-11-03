# Projeto de Desenvolvimento de Dashboard Analítico

**Avaliação de Produto 2º bimestre**

**Tema: Evidence**

## Sobre o projeto

Este repositório reúne o trabalho do nosso grupo para a Avaliação de Produto 2: um **seminário técnico sobre a ferramenta Evidence**, combinando a exposição teórica com uma **demonstração prática** de um dashboard real.

O Evidence é uma ferramenta de Business Intelligence *as Code* — os relatórios são escritos em **Markdown** com componentes embutidos e alimentados por **SQL**. Diferente dos modelos tradicionais de "arrastar e soltar", tudo fica versionado em Git, revisável e fácil de manter, com dashboards ricos em contexto.

Para a demonstração, montamos um dashboard completo (em `my-dashboard/`) conectado a um banco SQLite com métricas de usuários, público e dispositivos. Ele roda localmente via CLI ou Docker e alimenta as páginas de relatório deste site.

<center> <spam style="font-size: 24px">Integrantes</spam> </center>

| |
|---|
| Kayo Gabriel Soares da Silva |
| Ruan Gustavo Soares da Silva |
| Gabriel Pereira Goes |
| Pedro Henrique Coelho Lovatti |

## O que o seminário aborda

O trabalho exemplifica alguns dos tópicos demonstrados pelo enunciado, apoiados nos slides (`Evidence BI_040235.pptx`):

- **Contextualização do problema** — o caos do "arrasta e solta", dashboards quebrados e a falta de contexto nos relatórios.
- **Conceitos fundamentais** — BI as Code, Markdown + SQL, versionamento e rastreio.
- **Arquitetura básica** — conexão com o banco, execução das querys, compilação para Svelte e interatividade local.
- **Demonstração prática** — o dashboard rodando, com a visão geral e os relatórios de usuários.
- **Vantagens e limitações** — pontos fortes e fracos da ferramenta.
- **Exemplos práticos de uso** — relatórios reais construídos a partir do nosso banco de dados.

## Navegue pelos dados

- [Visão geral](/geral) — KPIs e evolução do público
- [Usuários Ativos por Mês](/Usuarios%20ativos%20por%20m%C3%AAs) — soma e média diária por categoria
