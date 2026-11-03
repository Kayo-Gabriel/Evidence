# Público

Dashboard das categorias de público: **Tamanho total do público** e **Taxa de crescimento do público**.

O gráfico mostra, dia a dia, o **valor diário** e a **média móvel dos últimos 28 dias** (`media_continua`). Use o seletor para trocar de categoria.

```sql categorias_publico
select distinct categoria as value, categoria as label
from data_evidence_analitics
where categoria in ('Tamanho total do público', 'Taxa de crescimento do público')
order by categoria
```

<Dropdown name="categoria_publico" data={categorias_publico} value="value" label="label" title="Categoria" defaultValue="Tamanho total do público"/>

```sql serie_publico
select data_registro as data, diaria as valor, 'Valor diário' as serie
from data_evidence_analitics
where categoria = '${inputs.categoria_publico.value}'
union all
select data_registro, media_continua, 'Média (28 dias)'
from data_evidence_analitics
where categoria = '${inputs.categoria_publico.value}'
order by data, serie
```

<LineChart data={serie_publico} x="data" y="valor" series="serie" legend title="Público por dia" subtitle="Valor diário × média dos últimos 28 dias"/>
