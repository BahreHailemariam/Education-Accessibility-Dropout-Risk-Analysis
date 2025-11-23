-- ============================================
-- 05. POWER BI REPORTING VIEWS
-- ============================================

-- Main Student Detail View
DROP VIEW IF EXISTS vw_student_overview;
CREATE VIEW vw_student_overview AS
SELECT
    s.student_id,
    s.school_id,
    sc.school_name,
    s.gender,
    s.ses,
    s.distance_km,
    s.disability,
    fs.attendance_rate,
    fs.academic_index,
    fs.accessibility_score,
    dr.risk_score,
    dr.risk_category,
    fs.dropped_out
FROM student_feature_set fs
JOIN students s ON s.student_id = fs.student_id
JOIN schools sc ON sc.school_id = s.school_id
LEFT JOIN dropout_risk_scores dr ON dr.student_id = s.student_id;

-- School Summary View
DROP VIEW IF EXISTS vw_school_summary;
CREATE VIEW vw_school_summary AS
SELECT
    sc.school_id,
    sc.school_name,
    sc.region,
    sc.district,
    k1.dropout_rate,
    k2.avg_attendance_rate,
    k3.infrastructure_index
FROM schools sc
LEFT JOIN kpi_dropout_rate k1 ON k1.school_id = sc.school_id
LEFT JOIN kpi_attendance_avg k2 ON k2.school_id = sc.school_id
LEFT JOIN kpi_infrastructure_index k3 ON k3.school_id = sc.school_id;

-- Intervention Planner View
DROP VIEW IF EXISTS vw_intervention_planner;
CREATE VIEW vw_intervention_planner AS
SELECT
    v.student_id,
    v.school_id,
    v.school_name,
    v.gender,
    v.ses,
    v.attendance_rate,
    v.academic_index,
    v.risk_score,
    v.risk_category,
    CASE
        WHEN v.risk_score >= 0.66 THEN 'Intensive Tutoring + Home Visits'
        WHEN v.risk_score >= 0.33 THEN 'Regular Counseling'
        ELSE 'Monitor Monthly'
    END AS recommended_intervention
FROM vw_student_overview v;
