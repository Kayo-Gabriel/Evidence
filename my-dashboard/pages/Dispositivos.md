# Dispositivos

Dashboard da categoria **Dispositivos ativos**.

O gráfico mostra, dia a dia, o **valor diário** e a **média móvel dos últimos 28 dias** (`media_continua`).

```sql serie_dispositivos
select data_registro as data, diaria as valor, 'Valor diário' as serie
from data_evidence_analitics
where categoria = 'Dispositivos ativos'
union all
select data_registro, media_continua, 'Média (28 dias)'
from data_evidence_analitics
where categoria = 'Dispositivos ativos'
order by data, serie
```

<LineChart data={serie_dispositivos} x="data" y="valor" series="serie" legend title="Dispositivos ativos por dia" subtitle="Valor diário × média dos últimos 28 dias"/>
