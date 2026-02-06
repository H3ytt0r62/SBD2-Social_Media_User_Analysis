-- Criação do schema DW (caso não exista)
CREATE SCHEMA IF NOT EXISTS DW;

-- Comentário no schema
COMMENT ON SCHEMA DW IS 'Camada GOLD/data-Werehouse - Dados prontos para análise e relatórios';

--Dimensão 1 informações pessoais 

CREATE TABLE DW.dim_psn_inf(
    srk_psn_inf SERIAL PRIMARY KEY,
    ubr_rrl            VARCHAR(10),
    icm_lvl            VARCHAR(30),
    ept_stt            VARCHAR(50),
    rlt_stt            VARCHAR(50),
    wkl_wrk_hrs       DECIMAL(5,2),
    scl_evt_per_mth        INTEGER,
    bok_rad_per_yea        INTEGER,
    vlt_hrs_per_mth   DECIMAL(5,2)
);



--Dimensão 2 informações de saúde

CREATE TABLE DW.dim_hlt_inf(
    srk_hlt_inf  SERIAL PRIMARY KEY,
    exr_hrs_per_wek    DECIMAL(5,2),
    slp_hrs_per_ngt    DECIMAL(4,2),
    dit_qly             VARCHAR(30),
    smk                 VARCHAR(20),
    alc_frq             VARCHAR(30),
    pcd_str_scr             INTEGER,
    slf_rpt_hap             INTEGER,
    bdy_mss_idx        DECIMAL(5,2),
    bld_prs_sys             INTEGER,
    bld_prs_dis             INTEGER,
    dly_stp_cnt             INTEGER
);


--Dimensão 3 informações de conta

CREATE TABLE DW.dim_act_inf(
    srk_act_inf  SERIAL PRIMARY KEY,
    dly_atv_mnt_itm    DECIMAL(7,2),
    rls_wtd_per_day         INTEGER,
    ste_vwd_per_day         INTEGER,
    ads_vwd_per_day         INTEGER,
    ads_clc_per_day         INTEGER,
    tme_on_fed_per_day      INTEGER,
    tme_on_exp_per_day      INTEGER,
    tme_on_rls_per_day      INTEGER,
    fls_cnt                 INTEGER,
    flg_cnt                 INTEGER,
    ctt_typ_pce         VARCHAR(50),
    prd_ctt_thm       VARCHAR(50),
    usr_egm_scr        DECIMAL(5,2)
);

-- Construção da tabela fato usuario

CREATE TABLE DW.fat_usr(
    srk_usr                             SERIAL PRIMARY KEY,
    age                                            INTEGER,
    gdr                                        VARCHAR(20),
    cty                                        VARCHAR(100),

    -- Chaves estrangeiras (Surrogate Keys)
    srk_act_inf INTEGER NOT NULL REFERENCES DW.dim_act_inf,
    srk_hlt_inf INTEGER NOT NULL REFERENCES DW.dim_hlt_inf,
    srk_psn_inf INTEGER NOT NULL REFERENCES DW.dim_psn_inf
);

-- ============================================================================
-- COMENTÁRIOS NAS COLUNAS
-- ============================================================================

-- Tabela Fato Usuário
COMMENT ON COLUMN DW.fat_usr.srk_usr IS 'Surrogate Key da tabela fat_usr';
COMMENT ON COLUMN DW.fat_usr.age IS 'Idade do usuário';
COMMENT ON COLUMN DW.fat_usr.gdr IS 'Gênero do usuário';
COMMENT ON COLUMN DW.fat_usr.cty IS 'País na qual o usuário reside';

-- Tabela Dimensão Informações Pessoais 
COMMENT ON COLUMN DW.dim_psn_inf.srk_psn_inf IS 'Surrogate Key da tabela dim_psn_inf';
COMMENT ON COLUMN DW.dim_psn_inf.ubr_rrl IS 'Descrição da área que o usuário reside, podendo ser rural ou urbana';
COMMENT ON COLUMN DW.dim_psn_inf.icm_lvl IS 'Nível de renda do usuário';
COMMENT ON COLUMN DW.dim_psn_inf.ept_stt IS 'Status de emprego do usuário';
COMMENT ON COLUMN DW.dim_psn_inf.rlt_stt IS 'Status de relacionamento';
COMMENT ON COLUMN DW.dim_psn_inf.wkl_wrk_hrs IS 'Horas de trabalho semanal';
COMMENT ON COLUMN DW.dim_psn_inf.scl_evt_per_mth IS 'Eventos sociais por mês';
COMMENT ON COLUMN DW.dim_psn_inf.bok_rad_per_yea IS 'Livros lidos por ano';
COMMENT ON COLUMN DW.dim_psn_inf.vlt_hrs_per_mth IS 'Horas de voluntariado por mês';

-- Tabela dimensão Informações de Saúde
COMMENT ON COLUMN DW.dim_hlt_inf.srk_hlt_inf IS 'Surrogate Key da tabela dim_hlt_inf';
COMMENT ON COLUMN DW.dim_hlt_inf.exr_hrs_per_wek IS 'Horas de exercício físico por semana';
COMMENT ON COLUMN DW.dim_hlt_inf.slp_hrs_per_ngt IS 'Horas de sono por dia';
COMMENT ON COLUMN DW.dim_hlt_inf.dit_qly IS 'Qualidade da dieta';
COMMENT ON COLUMN DW.dim_hlt_inf.smk IS 'Se fuma';
COMMENT ON COLUMN DW.dim_hlt_inf.alc_frq IS 'Frequência de ingestão de álcool';
COMMENT ON COLUMN DW.dim_hlt_inf.pcd_str_scr IS 'Escala de estresse';
COMMENT ON COLUMN DW.dim_hlt_inf.slf_rpt_hap IS 'Escala de felicidade descrita pelo usuário';
COMMENT ON COLUMN DW.dim_hlt_inf.bdy_mss_idx IS 'Índice de massa corporal';
COMMENT ON COLUMN DW.dim_hlt_inf.bld_prs_sys IS 'Pressão sanguínea sistólica';
COMMENT ON COLUMN DW.dim_hlt_inf.bld_prs_dis IS 'Pressão arterial diastólica';
COMMENT ON COLUMN DW.dim_hlt_inf.dly_stp_cnt IS 'Contagem de passos diários';

-- Tabela Dimensão Informação da Conta
COMMENT ON COLUMN DW.dim_act_inf.srk_act_inf IS 'Surrogate Key da tabela dim_act_inf';
COMMENT ON COLUMN DW.dim_act_inf.dly_atv_mnt_itm IS 'Minutos diários no instagram';
COMMENT ON COLUMN DW.dim_act_inf.rls_wtd_per_day IS 'Reels assistidos por dia';
COMMENT ON COLUMN DW.dim_act_inf.ste_vwd_per_day IS 'Stories visto por dia';
COMMENT ON COLUMN DW.dim_act_inf.ads_vwd_per_day IS 'Anúncios vistos por dia';
COMMENT ON COLUMN DW.dim_act_inf.ads_clc_per_day IS 'Anúncios vistos por dia';
COMMENT ON COLUMN DW.dim_act_inf.tme_on_fed_per_day IS 'Tempo no feed por dia';
COMMENT ON COLUMN DW.dim_act_inf.tme_on_exp_per_day IS 'Tempo no explorar por dia';
COMMENT ON COLUMN DW.dim_act_inf.tme_on_rls_per_day IS 'Tempo no reels por dia';
COMMENT ON COLUMN DW.dim_act_inf.fls_cnt IS 'Contagem de seguidores';
COMMENT ON COLUMN DW.dim_act_inf.flg_cnt IS 'Contagem de contas seguidas';
COMMENT ON COLUMN DW.dim_act_inf.ctt_typ_pce IS 'Tipo de conteúdo de preferência';
COMMENT ON COLUMN DW.dim_act_inf.prd_ctt_thm IS 'Tipo de tema preferido';
COMMENT ON COLUMN DW.dim_act_inf.usr_egm_scr IS 'Escore de engajamento de usuário';


