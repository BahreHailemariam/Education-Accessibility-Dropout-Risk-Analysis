# feature_engineering.py

import numpy as np
import pandas as pd

def add_academic_index(df):
    df["academic_index"] = (
        df[["math_score", "reading_score", "science_score"]].mean(axis=1)
    )
    return df

def add_accessibility_score(df):
    """
    Based on:
    - distance to school
    - infrastructure quality
    - transport availability
    """
    df["accessibility_score"] = (
        (1 / (df["distance_km"] + 1)) * 0.4 +
        df["facility_score"] * 0.4 +
        df["transport_score"] * 0.2
    )
    return df

def encode_categoricals(df):
    df = df.copy()
    df = pd.get_dummies(df, columns=["gender", "ses"], drop_first=True)
    return df

def build_feature_set(df):
    df = add_academic_index(df)
    df = add_accessibility_score(df)
    df = encode_categoricals(df)

    features = df[[
        "attendance_rate",
        "academic_index",
        "accessibility_score",
        "distance_km",
        "facility_score",
        "teacher_ratio",
        "gender_female",
        "ses_low",
        "ses_mid",
    ]]

    labels = df["dropped_out"] if "dropped_out" in df else None
    return features, labels

if __name__ == "__main__":
    print("Feature engineering module ready.")
