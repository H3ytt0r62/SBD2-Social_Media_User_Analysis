------ Consultas da camada gold ------

--------------------------------------

-- 1. verificação do SCHEMA DW

-- verificar a contagem de registros

SELECT 'dim_act_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_prdt
UNION ALL
SELECT 'dim_psn_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_hlt_inf
UNION ALL
SELECT 'dim_hlt_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_psn_inf
UNION ALL
SELECT 'fat_usr' AS tabela, COUNT(*) AS linhas FROM DW.fat_usr
ORDER BY tabela;


--- 2. Consultas relacionadas as informações gerais dos dados

---- 2.1. numero de usuarios por pais 

SELECT COUNT(cty) 
FROM DW.fat_usr 
GROUP BY cty;

--objetivo: encontrar o país onde a maioria dos usuários se encontram

---- 2.2 numeros de cliques por faixa étaria

SELECT age AS idade, ROUND(AVG(ads_clc_per_day),2) AS media_de_cliques
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY age;

---objetivo: encontrar qual faixa étaria mais seria propicia a clicar em um anuncio 

---2.3 Conteudo consumido por cada faixa étaria

SELECT age as idade, AVG(tme_on_rls_per_day) AS tempo_de_reels, AVG(tme_on_fed_per_day)AS tempo_no_feed,AVG( tme_on_exp_per_day)AS tempo_de_explorar,AVG( ste_vwd_per_day)AS stories_por_dia
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY age;


--- objetivo entender qual seria a melhor plataforma de conteudo para se divulgar anuncios dependendo da faixa étaria

--- 2.4 Paises que mais clicam em anuncios

SELECT cty AS pais, ROUND(AVG(ads_clc_per_day),2) AS media_de_cliques
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY cty;

--- Objetivo: entender qual pais é mais sucetivel a clicar em propagandas para focar os anuncios neste pais

--- 3 Consultas relacionadas a praticas de esporte

--- 3.1 Faixa étaria mais interessada em conteudos fitness

SELECT age AS idade, COUNT(*) FILTER (WHERE prd_ctt_thm = 'Fitness') AS interessados_fitness, COUNT(*) AS total_usuarios_na_faixa
FROM DW.fat_usr JOIN DW.dim_act_inf ON  fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY age;

-- objetivo: entender melhor qual é o melhor publico para investir em propaganda

--- 3.2 Quantidade de publico esportivo (media de exercicio fisico > 6 e não fumam)

WITH Media_maiorq_6 AS(
    SELECT *
    FROM DW.fat_usr JOIN DW.dim_hlt_inf ON  fat_usr.srk_hlt_inf = dim_hlt_inf.srk_hlt_inf
    WHERE exr_hrs_per_wek => 6;
)

SELECT age as idade, COUNT(*)
FROM Media_maiorq_6
WHERE smk = 'no'
GROUP BY age;

-- objetivo: entender a quatidade de publico disportivo temos em cada faixa etaria