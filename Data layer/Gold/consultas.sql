------ Consultas da camada gold ------

--------------------------------------

-- 1. verificação do SCHEMA DW

-- verificar a contagem de registros

SELECT 'dim_act_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_act_inf
UNION ALL
SELECT 'dim_psn_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_hlt_inf
UNION ALL
SELECT 'dim_hlt_inf' AS tabela, COUNT(*) AS linhas FROM DW.dim_psn_inf
UNION ALL
SELECT 'fat_usr' AS tabela, COUNT(*) AS linhas FROM DW.fat_usr
ORDER BY tabela;


--- 2. Consultas relacionadas as informações gerais dos dados

---- 2.1. numero de usuarios por pais 

SELECT cty as pais,COUNT(cty) as qtd_por_pais
FROM DW.fat_usr 
GROUP BY cty;

--objetivo: encontrar o país onde a maioria dos usuários se encontram

---- 2.2 numeros de cliques por faixa étaria

SELECT age AS idade, ROUND(AVG(ads_clc_per_day),2) AS media_de_cliques
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY age;

---objetivo: encontrar qual faixa étaria mais seria propicia a clicar em um anuncio 

---2.3 Conteúdo consumido por cada faixa étaria

SELECT age as idade, ROUND(AVG(tme_on_rls_per_day),2) AS tempo_de_reels, ROUND(AVG(tme_on_fed_per_day),2) AS tempo_no_feed,ROUND(AVG( tme_on_exp_per_day),2)AS tempo_de_explorar,ROUND(AVG( ste_vwd_per_day),2)AS stories_por_dia
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY age;


--- objetivo entender qual seria a melhor plataforma de conteudo para se divulgar anuncios dependendo da faixa étaria

--- 2.4 Países que mais clicam em anúncios

SELECT cty AS pais, ROUND(AVG(ads_clc_per_day),2) AS media_de_cliques
FROM DW.fat_usr JOIN DW.dim_act_inf ON fat_usr.srk_act_inf = dim_act_inf.srk_act_inf
GROUP BY cty;

--- Objetivo: entender qual pais é mais sucetivel a clicar em propagandas para focar os anuncios neste pais

----- 2.5 conteudo consumido por faixa etaria

WITH base_conteudo AS (
    SELECT 
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN '18-24 anos'
            WHEN age BETWEEN 25 AND 29 THEN '25-29 anos'
            WHEN age BETWEEN 30 AND 49 THEN '30-49 anos'
            ELSE '50+ anos'
        END AS faixa_etaria,
        srk_act_inf
    FROM DW.fat_usr
)

SELECT 
    b.faixa_etaria,
    ROUND(AVG(tme_on_fed_per_day),2) as tempo_no_feed,
    ROUND(AVG(tme_on_exp_per_day),2) as tempo_na_explorar,
    ROUND(AVG(tme_on_rls_per_day),2) as tempo_em_reels,
    ROUND(AVG(ste_vwd_per_day),2) as stories_por_dia
FROM base_conteudo b
JOIN DW.dim_act_inf h ON b.srk_act_inf = h.srk_act_inf
GROUP BY b.faixa_etaria
ORDER BY b.faixa_etaria;


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
    WHERE exr_hrs_per_wek > 6
)

SELECT age as idade, COUNT(*)
FROM Media_maiorq_6
WHERE smk = 'No'
GROUP BY age;

-- objetivo: entender a quatidade de publico disportivo temos em cada faixa etaria

-- 3.3 quantidade de sendatarios por pais

SELECT cty AS pais, COUNT(*) AS total_sedentarios
FROM DW.fat_usr JOIN DW.dim_hlt_inf ON  fat_usr.srk_hlt
WHERE exr_hrs_per_wek < 1
GROUP BY cty;

-- 3.4 media de exercicio fisico por idade

SELECT age as idade, ROUND(AVG(exr_hrs_per_wek),2) AS media_exercicio
FROM DW.fat_usr JOIN DW.dim_hlt_inf ON  fat_usr.srk_hlt_inf = dim_hlt_inf.srk_hlt_inf
GROUP BY age;

-- ============================================================================
-- 4. CONSULTAS RELACIONADAS A ÁREA DE SÁUDE
-- ============================================================================

-- ============================================================================
-- 4.1. QUANTIDADE DE FUMANTES POR PAÍS 
-- ============================================================================
-- Objetivo: medir a quantidade de fumantes nos países da América (Brasil, USA e Canada)

SELECT 
    f.cty AS Pais, 
    COUNT(*) AS Quantidade_Fumantes
FROM 
    DW.fat_usr f
JOIN 
    DW.dim_hlt_inf h ON f.srk_hlt_inf = h.srk_hlt_inf
WHERE 
    h.smk = 'Yes' 
GROUP BY 
    f.cty
ORDER BY 
    quantidade_fumantes DESC;

-- ============================================================================
-- 4.2. FUMANTES POR FAIXA ETÁRIA (CTE)
-- ============================================================================
-- Objetivo: medir a quantidade de fumantes por faixa etária nos países

WITH base_fumantes AS (
    SELECT 
        cty AS pais,
        CASE 
            WHEN age BETWEEN 18 AND 24 THEN '18-24 anos'
            WHEN age BETWEEN 25 AND 29 THEN '25-29 anos'
            WHEN age BETWEEN 30 AND 49 THEN '30-49 anos'
            ELSE '50+ anos'
        END AS faixa_etaria,
        srk_act_inf
    FROM DW.fat_usr
)

SELECT 
    b.pais,
    b.faixa_etaria,
    COUNT(*) AS total_fumantes
FROM base_fumantes b
JOIN DW.dim_hlt_inf h ON b.srk_hlt_inf = h.srk_hlt_inf
WHERE h.smk = 'Yes'
GROUP BY b.pais, b.faixa_etaria
ORDER BY b.pais, b.faixa_etaria;


-- ============================================================================
-- 4.3. GRUPO DE RISCO FUMANTES
-- ============================================================================
-- Objetivo: medir o grupo de risco de fumantes nos países estudados, 
-- considerando pessoas que fuma, maiores de 40 anos e que praticam menos de 5 horas de exercício por semana


SELECT 
    -- 1. Total da Base
    COUNT(*) AS base_total,

    -- 2. Apenas Fumantes
    SUM(CASE WHEN h.smk = 'Yes' THEN 1 ELSE 0 END) AS fumantes,

    -- 3. Grupo de Risco (Filtro completo)
    SUM(CASE WHEN h.smk = 'Yes' AND h.exr_hrs_per_wek < 5 AND f.age > 40 THEN 1 ELSE 0 END) AS grupo_risco

FROM 
    DW.fat_usr f
LEFT JOIN 
    DW.dim_hlt_inf h ON f.srk_hlt_inf = h.srk_hlt_inf;

-- ============================================================================
-- 4.4. GRUPO DE RISCO CARDIOVASCULAR (Hipertensão ou Obesidade)
-- ============================================================================
-- Objetivo: medir o grupo de risco cardiovascular nos países estudados 

SELECT 
    f.cty AS pais, 
    COUNT(*) AS total_risco_saude
FROM 
    DW.fat_usr f
JOIN 
    DW.dim_hlt_inf h ON f.srk_hlt_inf = h.srk_hlt_inf
WHERE 
    (h.bld_prs_sys >= 140 AND h.bld_prs_dis >= 90)
    OR 
    (h.bdy_mss_idx >= 30)
GROUP BY 
    f.cty
ORDER BY 
    total_risco_saude DESC;
