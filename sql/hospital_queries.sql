
-- ================================================
-- CLINICAL COMPASS
-- Hospital Operations Analytics
-- SQL Analysis Queries
-- ================================================

-- Query 1: Department Performance Overview
SELECT department,
       COUNT(*) as total_patients,
       ROUND(AVG(waiting_time_mins), 1) as avg_wait_mins,
       ROUND(AVG(length_of_stay_days), 1) as avg_los_days,
       ROUND(AVG(patient_satisfaction_score), 2) as avg_satisfaction,
       ROUND(AVG(efficiency_score), 1) as avg_efficiency
FROM patients
GROUP BY department
ORDER BY avg_efficiency DESC;

-- Query 2: Patient Funnel Analysis
SELECT treatment_status,
       COUNT(*) as count,
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM patients), 2) as percentage,
       ROUND(AVG(waiting_time_mins), 1) as avg_wait,
       ROUND(AVG(length_of_stay_days), 1) as avg_los
FROM patients
GROUP BY treatment_status
ORDER BY count DESC;

-- Query 3: Peak Hours with Window Function
SELECT hour,
       COUNT(*) as admissions,
       ROUND(AVG(waiting_time_mins), 1) as avg_wait,
       SUM(COUNT(*)) OVER (ORDER BY hour) as cumulative_admissions,
       CASE
           WHEN hour BETWEEN 9 AND 13 THEN 'Morning Peak'
           WHEN hour BETWEEN 17 AND 20 THEN 'Evening Peak'
           WHEN hour BETWEEN 0 AND 6 THEN 'Night Hours'
           ELSE 'Normal Hours'
       END as time_classification
FROM patients
GROUP BY hour
ORDER BY hour;

-- Query 4: Doctor Workload with RANK()
SELECT doctor,
       department,
       COUNT(*) as total_patients,
       ROUND(AVG(patient_satisfaction_score), 2) as avg_satisfaction,
       RANK() OVER (PARTITION BY department ORDER BY COUNT(*) DESC) as dept_rank
FROM patients
GROUP BY doctor, department
ORDER BY total_patients DESC
LIMIT 15;

-- Query 5: Readmission Analysis
SELECT department,
       COUNT(*) as total_discharged,
       SUM(readmission_flag) as readmitted,
       ROUND(SUM(readmission_flag)*100.0/COUNT(*), 2) as readmission_rate,
       CASE
           WHEN SUM(readmission_flag)*100.0/COUNT(*) > 6 THEN 'HIGH RISK'
           WHEN SUM(readmission_flag)*100.0/COUNT(*) > 4 THEN 'MEDIUM RISK'
           ELSE 'LOW RISK'
       END as risk_level
FROM patients
WHERE treatment_status = 'Discharged'
GROUP BY department
ORDER BY readmission_rate DESC;

-- Query 6: Monthly Trend with Moving Average
SELECT month,
       COUNT(*) as admissions,
       ROUND(AVG(waiting_time_mins), 1) as avg_wait,
       ROUND(AVG(COUNT(*)) OVER (
           ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ), 1) as moving_avg_3month
FROM patients
GROUP BY month
ORDER BY month;

-- Query 7: Efficiency Scorecard with CTE
WITH dept_metrics AS (
    SELECT department,
           COUNT(*) as total_patients,
           AVG(waiting_time_mins) as avg_wait,
           AVG(length_of_stay_days) as avg_los,
           AVG(efficiency_score) as avg_efficiency,
           AVG(patient_satisfaction_score) as avg_satisfaction,
           SUM(readmission_flag)*100.0/COUNT(*) as readmission_rate
    FROM patients
    GROUP BY department
)
SELECT department,
       ROUND(avg_efficiency, 1) as efficiency_score,
       ROUND(avg_wait, 1) as avg_wait_mins,
       ROUND(avg_los, 1) as avg_los_days,
       ROUND(avg_satisfaction, 2) as satisfaction,
       ROUND(readmission_rate, 2) as readmission_pct,
       CASE
           WHEN avg_efficiency > 70 THEN 'HIGH EFFICIENCY'
           WHEN avg_efficiency > 40 THEN 'MEDIUM EFFICIENCY'
           ELSE 'LOW EFFICIENCY'
       END as efficiency_rating
FROM dept_metrics
ORDER BY avg_efficiency DESC;
