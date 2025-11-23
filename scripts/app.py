# app.py

import streamlit as st
import pandas as pd
import joblib

from feature_engineering import build_feature_set
from clean_data import merge_data
from load_data import load_all_data

st.title("🎓 Education Dropout Risk Prediction Dashboard")

# Load & merge data
raw = load_all_data()
df = merge_data(raw)

# Load model
model = joblib.load("../models/dropout_risk_model.pkl")

st.sidebar.header("Student Search")
student_id = st.sidebar.text_input("Enter Student ID")

if student_id:
    student = df[df["student_id"] == int(student_id)]
    if student.empty:
        st.warning("Student not found.")
    else:
        st.subheader("Student Details")
        st.write(student)

        # Feature generation
        X, _ = build_feature_set(student)
        risk = model.predict_proba(X)[0][1]

        st.metric("Predicted Dropout Risk Probability", f"{risk:.2%}")

        if risk > 0.66:
            st.error("HIGH RISK – Immediate intervention recommended.")
        elif risk > 0.33:
            st.warning("Medium risk – Monitor regularly.")
        else:
            st.success("Low risk – No action needed.")

st.markdown("Powered by RandomForest + Attendance + Performance + SES + Accessibility")
