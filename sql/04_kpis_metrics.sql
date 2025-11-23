-- ============================================
-- 04. KPI & METRIC CALCULATIONS
-- ============================================

-- Dropout Rate
DROP VIEW IF EXISTS kpi_dropout_rate;
CREATE VIEW kpi_dropout_rate AS
SELECT
    s.school_id,
    sc.school_name,
    COUNT(*) FILTER (WHERE s.dropped_out = 1)::DECIMAL /
    COUNT(*) AS dropout_rate
FROM students s
JOIN schools sc ON sc.school_id = s.school_id
GROUP BY s.school_id, sc.school_name;

-- Average Attendance Rate per School
DROP VIEW IF EXISTS kpi_attendance_avg;
CREATE VIEW kpi_attendance_avg AS
SELECT
    school_id,
    AVG(attendance_rate) AS avg_attendance_rate
FROM student_feature_set
GROUP BY school_id;

-- Infrastructure Index
DROP VIEW IF EXISTS kpi_infrastructure_index;
CREATE VIEW kpi_infrastructure_index AS
SELECT
    school_id,
    (facility_score * 0.5) +
    (teacher_ratio * 0.3) +
    (transport_score * 0.2) AS infrastructure_index
FROM schools;

-- High-Risk Student Count
DROP VIEW IF EXISTS kpi_high_risk_students;
CREATE VIEW kpi_high_risk_students AS
SELECT
    d.school_id,
    COUNT(*) AS high_risk_count
FROM dropout_risk_scores dr
JOIN students d ON dr.student_id = d.student_id
WHERE dr.risk_category = 'High'
GROUP BY d.school_id;
