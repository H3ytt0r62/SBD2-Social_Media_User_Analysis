-- ============================================================================
-- SILVER LAYER: TABELA USER
-- Camada Silver - Dados de comportamento e perfil de usuários limpos
-- ============================================================================

-- Criação do schema silver (caso não exista)
CREATE SCHEMA IF NOT EXISTS silver;

-- Comentário no schema
COMMENT ON SCHEMA silver IS 'Camada Silver - Dados tratados e validados';

-- ============================================================================
-- TABELA: USER
-- ============================================================================
DROP TABLE IF EXISTS silver.user CASCADE;

CREATE TABLE silver.user (
    user_id                     BIGINT PRIMARY KEY,
    age                         INTEGER,
    gender                      VARCHAR(20),
    country                     VARCHAR(100),
    urban_rural                 VARCHAR(10),
    income_level                VARCHAR(30),
    employment_status           VARCHAR(50),
    relationship_status         VARCHAR(50),
    exercise_hours_per_week     DECIMAL(5,2),
    sleep_hours_per_night       DECIMAL(4,2),
    diet_quality                VARCHAR(30),
    smoking                     VARCHAR(20),
    alcohol_frequency           VARCHAR(30),
    perceived_stress_score      INTEGER,
    self_reported_happiness     INTEGER,
    body_mass_index             DECIMAL(5,2),
    blood_pressure_systolic     INTEGER,
    blood_pressure_diastolic    INTEGER,
    daily_steps_count           INTEGER,
    weekly_work_hours           DECIMAL(5,2),
    social_events_per_month     INTEGER,
    books_read_per_year         INTEGER,
    volunteer_hours_per_month    DECIMAL(5,2),
    daily_active_minutes_instagram DECIMAL(7,2),
    ads_viewed_per_day          INTEGER,
    ads_clicked_per_day         INTEGER,
    time_on_feed_per_day        DECIMAL(7,2),
    followers_count             INTEGER,
    following_count             INTEGER,
    content_type_preference     VARCHAR(50),
    preferred_content_theme     VARCHAR(50),
    user_engagement_score       DECIMAL(5,2),
    reels_watched_per_day       INTEGER,
    stories_viewed_per_day      INTEGER,
    time_on_explore_per_day     INTEGER,
    time_on_reels_per_day       INTEGER,

    -- Metadata
    created_at                  TIMESTAMP DEFAULT NOW()
);