-- ============================================
-- 02. DATA CLEANING / STANDARDIZATION
-- ============================================

-- Standardize gender values
UPDATE students
SET gender = LOWER(gender);

UPDATE students
SET gender = 'unknown'
WHERE gender IS NULL OR gender = '';

-- Standardize SES
UPDATE students
SET ses = LOWER(ses);

UPDATE students
SET ses = 'unknown'
WHERE ses IS NULL OR ses = '';

-- Fix attendance status
UPDATE attendance
SET status = LOWER(status);

UPDATE attendance
SET status = 'absent'
WHERE status IS NULL OR status = '';

-- Fix negative or unrealistic distances
UPDATE students
SET distance_km = NULL
WHERE distance_km < 0;

UPDATE students
SET distance_km =
(
    SELECT PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY distance_km)
    FROM students
)
WHERE distance_km IS NULL;

-- Fix missing test scores
UPDATE performance
SET math_score = 0
WHERE math_score IS NULL;

UPDATE performance
SET reading_score = 0
WHERE reading_score IS NULL;

UPDATE performance
SET science_score = 0
WHERE science_score IS NULL;
