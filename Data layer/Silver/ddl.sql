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

-- ============================================================================
-- COMENTÁRIOS NAS COLUNAS
-- ============================================================================

COMMENT ON COLUMN silver.user.user_id IS 'Id do usuário';
COMMENT ON COLUMN silver.user.age IS 'Idade do usuário';
COMMENT ON COLUMN silver.user.gender IS 'Gênero do usuário';
COMMENT ON COLUMN silver.user.country IS 'País na qual o usuário reside';
COMMENT ON COLUMN silver.user.urban_rural IS 'Descrição da área que o usuário reside, podendo ser rural ou urbana';
COMMENT ON COLUMN silver.user.income_level IS 'Nível de renda do usuário';
COMMENT ON COLUMN silver.user.employment_status IS 'Status de emprego do usuário';
COMMENT ON COLUMN silver.user.relationship_status IS 'Status de relacionamento';
COMMENT ON COLUMN silver.user.exercise_hours_per_week IS 'Horas de exercício físico por semana';
COMMENT ON COLUMN silver.user.sleep_hours_per_night IS 'Horas de sono por dia';
COMMENT ON COLUMN silver.user.diet_quality IS 'Qualidade da dieta';
COMMENT ON COLUMN silver.user.smoking IS 'Se fuma';
COMMENT ON COLUMN silver.user.alcohol_frequency IS 'Frequência de ingestão de álcool';
COMMENT ON COLUMN silver.user.perceived_stress_score IS 'Escala de estresse';
COMMENT ON COLUMN silver.user.self_reported_happiness IS 'Escala de felicidade descrita pelo usuário';
COMMENT ON COLUMN silver.user.body_mass_index IS 'Índice de massa corporal';
COMMENT ON COLUMN silver.user.blood_pressure_systolic IS 'Pressão sanguínea sistólica';
COMMENT ON COLUMN silver.user.blood_pressure_diastolic IS 'Pressão arterial diastólica';
COMMENT ON COLUMN silver.user.daily_steps_count IS 'Contagem de passos diários';
COMMENT ON COLUMN silver.user.weekly_work_hours IS 'Horas de trabalho semanal';
COMMENT ON COLUMN silver.user.social_events_per_month IS 'Eventos sociais por mês';
COMMENT ON COLUMN silver.user.books_read_per_year IS 'Livros lidos por ano';
COMMENT ON COLUMN silver.user.volunteer_hours_per_month IS 'Horas de voluntariado por mês';
COMMENT ON COLUMN silver.user.daily_active_minutes_instagram IS 'Minutos diários no instagram';
COMMENT ON COLUMN silver.user.ads_viewed_per_day IS 'Anúncios vistos por dia';
COMMENT ON COLUMN silver.user.ads_clicked_per_day IS 'Anúncios vistos por dia';
COMMENT ON COLUMN silver.user.time_on_feed_per_day IS 'Tempo no feed por dia';
COMMENT ON COLUMN silver.user.followers_count IS 'Contagem de seguidores';
COMMENT ON COLUMN silver.user.following_count IS 'Contagem de contas seguidas';
COMMENT ON COLUMN silver.user.content_type_preference IS 'Tipo de conteúdo de preferência';
COMMENT ON COLUMN silver.user.preferred_content_theme IS 'Tipo de tema preferido';
COMMENT ON COLUMN silver.user.user_engagement_score IS 'Escore de engajamento de usuário';
COMMENT ON COLUMN silver.user.reels_watched_per_day IS 'Reels assistidos por dia';
COMMENT ON COLUMN silver.user.stories_viewed_per_day IS 'Stories visto por dia';
COMMENT ON COLUMN silver.user.time_on_explore_per_day IS 'Tempo no explorar por dia';
COMMENT ON COLUMN silver.user.time_on_reels_per_day IS 'Tempo no reels por dia';


-- ============================================================================
-- ÍNDICES PARA PERFORMANCE
-- ============================================================================

CREATE UNIQUE INDEX idx_user_id ON silver.user (user_id);
CREATE INDEX idx_user_country ON silver.user (country);
CREATE INDEX idx_user_urban_rural ON silver.user (urban_rural);
CREATE INDEX idx_user_age ON silver.user (age);
CREATE INDEX idx_user_gender ON silver.user (gender);
CREATE INDEX idx_user_income ON silver.user (income_level);
CREATE INDEX idx_user_employment ON silver.user (employment_status);
CREATE INDEX idx_user_relationship ON silver.user (relationship_status);
CREATE INDEX idx_user_exercise ON silver.user (exercise_hours_per_week);
CREATE INDEX idx_user_sleep ON silver.user (sleep_hours_per_night);
CREATE INDEX idx_user_diet ON silver.user (diet_quality);
CREATE INDEX idx_user_smoking ON silver.user (smoking);
CREATE INDEX idx_user_alcohol ON silver.user (alcohol_frequency);
CREATE INDEX idx_user_stress ON silver.user (perceived_stress_score);
CREATE INDEX idx_user_happiness ON silver.user (self_reported_happiness);
CREATE INDEX idx_user_bmi ON silver.user (body_mass_index);
CREATE INDEX idx_user_instagram_minutes ON silver.user (daily_active_minutes_instagram);
CREATE INDEX idx_user_reels_watched ON silver.user (reels_watched_per_day);
CREATE INDEX idx_user_stories_viewed ON silver.user (stories_viewed_per_day);
CREATE INDEX idx_user_time_feed ON silver.user (time_on_feed_per_day);
CREATE INDEX idx_user_time_explore ON silver.user (time_on_explore_per_day);
CREATE INDEX idx_user_time_reels ON silver.user (time_on_reels_per_day);
CREATE INDEX idx_user_engagement_score ON silver.user (user_engagement_score);
CREATE INDEX idx_user_content_pref ON silver.user (content_type_preference);
CREATE INDEX idx_user_theme_pref ON silver.user (preferred_content_theme);