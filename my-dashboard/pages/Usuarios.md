# Usuários

Dashboard das categorias de usuários: **Usuários ativos por mês**, **Aquisições de usuários** e **Perda de usuários**.

O gráfico mostra, dia a dia, o **valor diário** e a **média móvel dos últimos 28 dias** (`media_continua`). Use o seletor para trocar de categoria.

```sql categorias_usuario
select distinct categoria as value, categoria as label
from data_evidence_analitics
where categoria in ('Usuários ativos por mês', 'Aquisições de usuários', 'Perda de usuários')
order by categoria
```

<Dropdown name="categoria_usuario" data={categorias_usuario} value="value" label="label" title="Categoria" defaultValue="Usuários ativos por mês"/>

```sql serie_usuario
select data_registro as data, diaria as valor, 'Valor diário' as serie
from data_evidence_analitics
where categoria = '${inputs.categoria_usuario.value}'
union all
select data_registro, media_continua, 'Média (28 dias)'
from data_evidence_analitics
where categoria = '${inputs.categoria_usuario.value}'
order by data, serie
```

<LineChart data={serie_usuario} x="data" y="valor" series="serie" legend title="Usuários por dia" subtitle="Valor diário × média dos últimos 28 dias"/>
