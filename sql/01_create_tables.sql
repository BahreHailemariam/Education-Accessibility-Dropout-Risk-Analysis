-- ============================================
-- 01. CREATE CORE TABLES
-- ============================================

CREATE TABLE schools (
    school_id          INT PRIMARY KEY,
    school_name        VARCHAR(255),
    region             VARCHAR(100),
    district           VARCHAR(100),
    rural_urban        VARCHAR(50),
    capacity           INT,
    facility_score     DECIMAL(5,2),
    teacher_ratio      DECIMAL(5,2),
    transport_score    DECIMAL(5,2),
    latitude           DECIMAL(10,6),
    longitude          DECIMAL(10,6)
);

CREATE TABLE students (
    student_id        INT PRIMARY KEY,
    school_id         INT,
    first_name        VARCHAR(100),
    last_name         VARCHAR(100),
    gender            VARCHAR(20),
    ses               VARCHAR(50),
    disability        VARCHAR(50),
    distance_km       DECIMAL(5,2),
    dropped_out       INT DEFAULT 0,  -- 0 = no, 1 = yes
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

CREATE TABLE attendance (
    attendance_id     SERIAL PRIMARY KEY,
    student_id        INT,
    date              DATE,
    status            VARCHAR(20),  -- “present” / “absent”
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE performance (
    performance_id     SERIAL PRIMARY KEY,
    student_id         INT,
    math_score         DECIMAL(5,2),
    reading_score      DECIMAL(5,2),
    science_score      DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE dropout_risk_scores (
    score_id          SERIAL PRIMARY KEY,
    student_id        INT,
    risk_score        DECIMAL(5,4),
    risk_category     VARCHAR(20),
    model_version     VARCHAR(50),
    generated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
