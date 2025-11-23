-- ============================================
-- 03. FEATURE ENGINEERING
-- ============================================

-- Attendance Rate
DROP TABLE IF EXISTS fea_attendance_rate;
CREATE TABLE fea_attendance_rate AS
SELECT
    student_id,
    AVG(CASE WHEN status = 'present' THEN 1 ELSE 0 END)::DECIMAL(5,4) AS attendance_rate
FROM attendance
GROUP BY student_id;

-- Academic Index
DROP TABLE IF EXISTS fea_academic_index;
CREATE TABLE fea_academic_index AS
SELECT
    student_id,
    (math_score + reading_score + science_score) / 3 AS academic_index
FROM performance;

-- Accessibility Score
-- weighted: distance, facilities, transport
DROP TABLE IF EXISTS fea_accessibility_score;
CREATE TABLE fea_accessibility_score AS
SELECT
    s.student_id,
    (
        (1.0 / (s.distance_km + 1)) * 0.4 +
        sc.facility_score * 0.4 +
        sc.transport_score * 0.2
    ) AS accessibility_score
FROM students s
JOIN schools sc USING (school_id);

-- Combine final engineered table
DROP TABLE IF EXISTS student_feature_set;
CREATE TABLE student_feature_set AS
SELECT 
    s.student_id,
    s.school_id,
    s.gender,
    s.ses,
    s.disability,
    s.distance_km,
    a.attendance_rate,
    p.academic_index,
    ac.accessibility_score,
    sc.teacher_ratio,
    sc.facility_score,
    sc.transport_score,
    s.dropped_out
FROM students s
LEFT JOIN fea_attendance_rate a USING (student_id)
LEFT JOIN fea_academic_index p USING (student_id)
LEFT JOIN fea_accessibility_score ac USING (student_id)
LEFT JOIN schools sc ON sc.school_id = s.school_id;
