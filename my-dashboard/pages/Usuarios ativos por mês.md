# Dados dos usuarios

Primeiro dashboard marcado para os dados das categorias "Usuarios ativos por mês", "Aquisição de usuarios", "Perda de Usuarios" .

Os dados presentes dessa categoria é a quantidade diaria de usuarios ativos e a media de usuarios nos ultimos 28 dias.

```sql users_actives_sumary
select
    categoria,
    sum(diaria) as soma_usuarios,
    avg(diaria) as media_diaria
from data_evidence_analitics
where categoria in (
    'Aquisições de usuários', 
    'Perda de usuários', 
    'Usuários ativos por mês'
)
group by categoria
order by soma_usuarios desc;
```

<BarChart data="{users_actives_sumary}" x="categoria" y="soma_usuarios"/>