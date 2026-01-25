-- Criação do schema DW (caso não exista)
CREATE SCHEMA IF NOT EXISTS DW;

-- Comentário no schema
COMMENT ON SCHEMA DW IS 'Camada GOLD/data-Werehouse - Dados prontos para análise e relatórios';

--Dimensão 1 informações pessoais 

CREATE TABLE DW.dim_psn_inf(
    srk_psn_ifn SERIAL PRIMARY KEY,
    ubr_rrl            VARCHAR(10),
    icm_lvl            VARCHAR(30),
    ept_stt            VARCHAR(50),
    rlt_stt            VARCHAR(50),
    wkl_wrk_hrs       DECIMAL(5,2),
    scl_evt_per_mnt        INTEGER,
    bok_rad_per_yea        INTEGER,
    vlt_hrs_per_mnt   DECIMAL(5,2)
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
    srk_usr                   INTEGER NOT NULL PRIMARY KEY,
    age                                            INTEGER,
    gdr                                        VARCHAR(20),
    cty                                        VARCHAR(100),

    -- Chaves estrangeiras (Surrogate Keys)
    srk_act_inf INTEGER NOT NULL REFERENCES DW.dim_act_inf,
    srk_hlt_inf INTEGER NOT NULL REFERENCES DW.dim_hlt_inf,
    srk_psn_ifn INTEGER NOT NULL REFERENCES DW.dim_psn_inf
);
