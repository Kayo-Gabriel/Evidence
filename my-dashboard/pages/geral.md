# Visão geral

Resumo das métricas mais recentes do produto — valores do último dia registrado, com a evolução do público ao longo do período.

```sql home_kpis
select
    (select diaria from data_evidence_analitics where categoria = 'Usuários ativos por mês' order by data_registro desc limit 1) as usuarios_ativos,
    (select diaria from data_evidence_analitics where categoria = 'Tamanho total do público' order by data_registro desc limit 1) as tamanho_publico,
    (select diaria from data_evidence_analitics where categoria = 'Dispositivos ativos' order by data_registro desc limit 1) as dispositivos_ativos,
    (select diaria from data_evidence_analitics where categoria = 'Aquisições de usuários' order by data_registro desc limit 1) as aquisicoes_dia,
    (select diaria from data_evidence_analitics where categoria = 'Perda de usuários' order by data_registro desc limit 1) as perda_dia,
    (select diaria from data_evidence_analitics where categoria = 'Taxa de crescimento do público' order by data_registro desc limit 1) as taxa_crescimento;
```

<Grid cols="3" gapSize="lg">
    <BigValue data="{home_kpis}" value="usuarios_ativos" title="Usuários ativos" fmt="num1k" />
    <BigValue data="{home_kpis}" value="tamanho_publico" title="Tamanho total do público" fmt="num1k" />
    <BigValue data="{home_kpis}" value="dispositivos_ativos" title="Dispositivos ativos" fmt="num1k" />
    <BigValue data="{home_kpis}" value="aquisicoes_dia" title="Aquisições no último dia" fmt="num0" />
    <BigValue data="{home_kpis}" value="perda_dia" title="Perda no último dia" fmt="num0" />
    <BigValue data="{home_kpis}" value="taxa_crescimento" title="Taxa de crescimento" fmt="0.0&quot;%&quot;" />
</Grid>

# Evolução do público

```sql home_tendencia
select
    data_registro,
    categoria,
    diaria
from data_evidence_analitics
where categoria in (
    'Usuários ativos por mês',
    'Tamanho total do público',
    'Dispositivos ativos'
)
  and diaria > 0
order by data_registro;
```

<LineChart data="{home_tendencia}" x="data_registro" y="diaria" series="categoria" legend />

# Análises detalhadas

- [Usuários Ativos por Mês](/Usuarios%20ativos%20por%20m%C3%AAs) — soma e média diária por categoria (aquisição, perda e ativos) em gráfico de barras.
