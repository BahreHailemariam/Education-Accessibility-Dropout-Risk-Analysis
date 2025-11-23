# train_model.py

import joblib
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

from load_data import load_all_data
from clean_data import merge_data
from feature_engineering import build_feature_set

MODEL_PATH = "../models/dropout_risk_model.pkl"

def train_model():
    raw = load_all_data()
    df = merge_data(raw)

    X, y = build_feature_set(df)

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.25, random_state=42
    )

    # Model
    model = RandomForestClassifier(
        n_estimators=300,
        max_depth=8,
        class_weight="balanced",
        random_state=42
    )

    # Train
    model.fit(X_train, y_train)

    # Evaluate
    preds = model.predict(X_test)
    proba = model.predict_proba(X_test)[:, 1]

    print("\n📌 Classification Report:\n", classification_report(y_test, preds))
    print("\n🔥 ROC-AUC:", roc_auc_score(y_test, proba))

    # Save model
    joblib.dump(model, MODEL_PATH)
    print(f"\n✅ Model saved at: {MODEL_PATH}")

if __name__ == "__main__":
    train_model()
