# 🏥 Clinical Compass — Navigating Hospital Operations Through Advanced Analytics

## 🎯 Business Problem
Hospitals waste crores due to operational inefficiency — patients wait too long, wrong departments get overcrowded, beds are underutilized, and high readmission rates cost hospitals money. This project builds a complete Hospital Operations Intelligence System that identifies bottlenecks and gives actionable recommendations.

## 🔗 Live Dashboard
[👉 Click here to view Power BI Dashboard](YOUR_POWERBI_LINK)

## 📊 Project Type
Funnel Analysis + Operational Intelligence — End-to-end hospital operations analytics

## 🛠️ Tools
| Tool | Purpose |
|---|---|
| Python | Data generation, cleaning, EDA |
| SQL (SQLite) | Advanced analytics with CTEs, window functions |
| Power BI | 5-page operational intelligence dashboard |

## 📁 Dataset
- 15,000 synthetic patient records (2023–2024)
- 10 departments, 30+ doctors, 4 hospital branches
- Columns: patient_id, department, doctor, waiting_time_mins, length_of_stay_days, readmission_flag, efficiency_score, patient_satisfaction_score and more

## 🔍 Key Findings
- Emergency department has highest patient volume but lowest waiting time
- Oncology has highest average length of stay at 10+ days
- Peak admission hours are 9AM–1PM and 5PM–8PM
- Readmission rate exceeds benchmark in 3 departments
- Patient satisfaction directly correlates with waiting time reduction

## 📈 Dashboard Pages
1. Executive Overview — KPIs, admissions by department, monthly trend
2. Patient Funnel — Registration to discharge flow analysis
3. Department Intelligence — Efficiency scorecard per department
4. Doctor & Satisfaction — Workload and satisfaction analysis
5. Operational Efficiency — Red/Yellow/Green efficiency ratings

## 🔑 SQL Highlights
- CTEs for efficiency scorecard calculation
- RANK() OVER for doctor performance ranking
- Window functions for cumulative admissions and moving averages
- CASE WHEN for risk classification

## 💡 Business Recommendations
1. Add triage nurses during peak hours (9AM-1PM) to reduce waiting time
2. Oncology and Psychiatry need more bed allocation — highest LOS
3. Implement discharge planning 24 hours before expected discharge date
4. Create readmission prevention program for top 3 high-risk departments
5. Install patient flow monitoring system in Emergency department


