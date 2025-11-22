# 🎓 Education Accessibility & Dropout Risk Analysis

**Predicting student dropout risk & analyzing accessibility gaps using data science, SQL, and Power BI**

## 📌 Project Overview

This project focuses on understanding and predicting student dropout risks by analyzing academic performance, socio-economic factors, attendance, accessibility challenges, and school infrastructure.

The goal is to enable education ministries, NGOs, and school administrators to identify at-risk students early, improve resource allocation, and promote equitable education access.

## 🎯 Objectives

✔ Analyze school accessibility & student equity metrics<br />
✔ Build ML models to identify high dropout-risk students<br />
✔ Explore gender, region, and socio-economic disparities<br />
✔ Predict completion likelihood using classification models<br />
✔ Create dashboards to help policymakers take action<br />
✔ Produce SQL-based feature engineering for repeatability

## 🧱 Project Architecture

```powershel
Data Sources → SQL Cleaning → Feature Engineering → ML Modeling → Insights → Dashboards
```

📂 Folder Structure
```pgsql
Education_Dropout_Risk_Analysis/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── scripts/
│   ├── load_data.py
│   ├── clean_data.py
│   ├── feature_engineering.py
│   ├── train_model.py
│   └── app.py  # optional Streamlit dashboard
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_feature_engineering.sql
│   ├── 04_kpis_metrics.sql
│   └── 05_views_for_powerbi.sql
│
├── dashboard/
│   └── PowerBI_Report_Spec.md
│
├── docs/
│   └── Workflow_Spec.md
│
├── models/
│   └── dropout_risk_model.pkl
│
├── requirements.txt
└── README.md
```
## 🧮 Data Sources
**Typical datasets:**

- **Student Profiles** (age, gender, SES level, disabilities)

- **Academic Performance** (grades, test scores)

- **Attendance Records**

- **Accessibility Factors** (transportation, distance to school)

- **School Infrastructure** (teachers, facilities, ratios)

- **Household Factors** (literacy of parents, income)

- **Community Data** (crime rates, local resources)

## 🧼 1. Data Cleaning

Performed in SQL + Python:

- Fix missing demographic data

- Normalize categorical fields (grade, gender, SES)

- Remove duplicates

- Convert attendance patterns into usable numerical features

- Fix school and student IDs

- Remove inconsistent grade entries

Example Python snippet:
```python
df['attendance_rate'] = df['days_present'] / df['days_total']
df['is_low_income'] = df['income_level'].apply(lambda x: 1 if x == 'low' else 0)
```

## 🧠 2. Feature Engineering
**Student-level:**

- Attendance trend features

- Dropout label (0/1)

- Academic difficulty index

- Transition risk (grade-to-grade stability)

- Distance accessibility index

**School-level:**

- Student–teacher ratio

- Infrastructure score

- Accessibility score

- District-level dropout history

**Interaction Features:**

- SES × attendance

- Parent-literacy × performance

- Gender × transportation accessibility

## 🤖 3. Machine Learning Modeling

Models used:

- **Logistic Regression**

- **Random Forest**

- **XGBoost Classifier**

- **Neural network (optional)**

Target:

```csharp

dropout_risk (0 = retained, 1 = dropped out)

```

Evaluated using:

- ROC-AUC

- F1 Score

- Confusion Matrix

- Precision-Recall Curve

Example model snippet:

```python

from xgboost import XGBClassifier

model = XGBClassifier(max_depth=5, learning_rate=0.1)
model.fit(X_train, y_train)
preds = model.predict_proba(X_test)[:,1]
```

