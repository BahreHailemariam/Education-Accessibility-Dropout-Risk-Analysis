# 📊  Power BI Report Spec — Education Accessibility & Dropout Risk Analysis


This dashboard provides a comprehensive view of student accessibility challenges, dropout risk factors, and actionable insights for policymakers, school administrators, and NGOs. It combines demographic, academic, socio-economic, attendance, and school infrastructure datasets into a unified reporting platform.

## 1️⃣ Education Access Overview
### 🎯 Purpose

Identify accessibility gaps across regions, genders, income groups, and school types. This page helps decision-makers understand who has access, who is left behind, and why.

### 🗂️ Key Visuals
✔ **Enrollment vs Capacity**

- Bar or stacked chart comparing:

    - Total school capacity

    - Enrolled students

    - Unused capacity

- Filters: region, grade, school type (rural/urban)

✔ **Gender & SES Accessibility Gaps**

- Clustered bar chart (Male vs Female)

- Low-income vs medium-income vs high-income enrollment

- Accessibility score heatmap (distance, transport availability)

✔ **Attendance Distribution**

Distribution graph of attendance (%)

- Drilldown by:

   - Grade level

   - Gender

   - SES category

✔ **School Infrastructure Index**

A composite KPI combining:

- Student–teacher ratio

- Classroom availability

- Electricity & water access

- Internet connection

- Disability support rooms<br />
Shown as:

- Choropleth map

- KPI trend card (index YoY change)


## 2️⃣ Dropout Risk Monitoring
### 🎯 Purpose

Highlight students at highest risk and show predictors influencing dropout patterns.

### 🗂️ Key Visuals
✔ **At-Risk Student Count**

- KPI card showing total at-risk students

- Breakdown:

    - Low Risk: Probability < 0.33

    - Medium Risk: 0.33–0.66

    - High Risk: > 0.66

✔ **Risk Distribution**

- Donut/pie chart: percentage in each risk category

- Bar chart: risk categories across regions or schools

✔ **Top Predictors (Feature Importance)**

Feature importance bar chart (XGBoost/Random Forest)
Common predictors include:

- Attendance decline

- Low grades in core subjects

- SES level

- Distance to school

- Parent literacy

✔ **Student-Level Risk Indicators**

Table with:

   - Student ID

   - Name (optional / pseudonymized)

   - Attendance rate

   - Performance index

   - SES level

   - Risk score

   - Recommended interventions

3️⃣ Equity & Inclusion Analytics
🎯 Purpose

Understand equity gaps by socio-economic, demographic, and geographic factors.

🗂️ Key Visuals
✔ Disability Support Gap

KPI: % of students with disabilities lacking adequate resources

Bar chart: resources vs needs by school

✔ Rural vs Urban Accessibility Gap

Map visualization showing dropout risk differences

Transportation access levels

Teacher availability comparison

✔ Socio-Economic Segmentation

Tree map showing enrollment by SES

Dropout rate by SES group

Heatmap of SES × attendance

✔ Gender Disparity in Performance & Attendance

Line chart of gender-based grade averages

Box plot showing attendance variation by gender

Gap index KPI:

Gender Gap Index = Avg(Female Score) – Avg(Male Score)
