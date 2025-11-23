# load_data.py

import pandas as pd
from pathlib import Path

DATA_DIR = Path("../data")

def load_students():
    """Load student demographic data."""
    path = DATA_DIR / "raw" / "students.csv"
    return pd.read_csv(path)

def load_schools():
    """Load school capacity, infrastructure, and location data."""
    path = DATA_DIR / "raw" / "schools.csv"
    return pd.read_csv(path)

def load_attendance():
    """Load attendance logs for students."""
    path = DATA_DIR / "raw" / "attendance.csv"
    return pd.read_csv(path, parse_dates=["date"])

def load_performance():
    """Load academic performance dataset."""
    path = DATA_DIR / "raw" / "performance.csv"
    return pd.read_csv(path)

def load_all_data():
    """Return all datasets together."""
    return {
        "students": load_students(),
        "schools": load_schools(),
        "attendance": load_attendance(),
        "performance": load_performance(),
    }

if __name__ == "__main__":
    data = load_all_data()
    for k, df in data.items():
        print(f"> Loaded {k}: shape = {df.shape}")
