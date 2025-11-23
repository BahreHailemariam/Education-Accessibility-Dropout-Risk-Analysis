# clean_data.py

import pandas as pd
from load_data import load_all_data

def clean_students(df):
    df = df.copy()
    
    # Standardize column names
    df.columns = df.columns.str.lower().str.strip()
    
    # Replace inconsistent SES labels
    df["ses"] = df["ses"].str.lower().str.replace(" ", "_")
    
    # Fill missing values
    df["gender"] = df["gender"].fillna("unknown")
    df["ses"] = df["ses"].fillna("unknown")
    df["distance_km"] = df["distance_km"].fillna(df["distance_km"].median())
    
    return df

def clean_attendance(df):
    df = df.copy()
    df.columns = df.columns.str.lower()

    # Fix incorrect formats
    df["status"] = df["status"].str.lower()

    # Fill missing attendance status
    df["status"] = df["status"].fillna("absent")
    return df

def clean_performance(df):
    df = df.copy()
    df.columns = df.columns.str.lower()
    
    # Ensure numeric test scores
    score_cols = ["math_score", "reading_score", "science_score"]
    for col in score_cols:
        df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)
    
    return df

def merge_data(data):
    """Merge datasets into a unified record per student."""
    students = clean_students(data["students"])
    attendance = clean_attendance(data["attendance"])
    performance = clean_performance(data["performance"])
    schools = data["schools"]

    # Attendance summary per student
    attendance_summary = (
        attendance.groupby("student_id")["status"]
        .apply(lambda x: (x == "present").mean())
        .reset_index(name="attendance_rate")
    )

    # Merge everything
    merged = (
        students
        .merge(attendance_summary, on="student_id", how="left")
        .merge(performance, on="student_id", how="left")
        .merge(schools, on="school_id", how="left")
    )

    return merged

if __name__ == "__main__":
    raw = load_all_data()
    merged = merge_data(raw)
    print(merged.head())
