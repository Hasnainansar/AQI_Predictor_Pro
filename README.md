# AQI Predictor Pro

> A research-grade air quality prediction system built for UK cities — powered by machine learning, wrapped in a clean Streamlit interface.

---

## What is this?

AQI Predictor Pro helps you monitor, analyze, and predict air quality across major UK cities. It combines real-time (or simulated DEFRA-style) air quality data with three machine learning models to give you PM2.5 forecasts, health alerts, and downloadable PDF reports — all from a single dashboard.

Whether you're a researcher, an environmental analyst, or just curious about what's in the air, this tool gives you the data and predictions to make sense of it.

---

## What's inside

- **Real-Time Dashboard** — Live air quality metrics (PM2.5, PM10, NO2, O3) for any selected UK city, with 24-hour trend charts and a pollutant composition breakdown.
- **Model Laboratory** — Train and compare three ML models side by side: Random Forest, LSTM, and a Hybrid CNN-LSTM. See MSE, RMSE, MAE, and R² scores in a clean comparison table.
- **Multi-City Analysis** — Compare air quality across London, Manchester, Birmingham, Leeds, Glasgow, and Liverpool simultaneously on a single chart.
- **Advanced Analytics** — A real-time alert system that flags cities exceeding safe PM2.5 thresholds with health status labels.
- **Report Generator** — Generate and download professional PDF reports for any city, including current readings, model predictions, and health recommendations.
- **UK Timezone Clock** — A live clock (Europe/London) is displayed right in the header, so your timestamps are always accurate.

---

## Tech Stack

| Layer | Tools |
|---|---|
| Frontend | Streamlit |
| ML Models | Scikit-Learn, TensorFlow / Keras |
| Data Viz | Plotly |
| PDF Reports | ReportLab |
| Data Source | DEFRA UK Air Quality (CSV) / Open-Meteo API |
| Time | pytz (Europe/London) |

---

## Getting Started

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

### 2. Run the app

```bash
streamlit run app.py
```

The app will open in your browser at `http://localhost:8501`.

---

## How to use it

1. **Select your cities** from the sidebar (up to 6 UK cities supported).
2. **Choose a data mode** — CSV for offline/simulated data, or Live API for real-time feeds.
3. Hit **Load Data** to fetch air quality readings.
4. Navigate between pages using the sidebar to explore the dashboard, train models, compare cities, or generate reports.

---

## Project Structure

```
aqi-predictor-pro/
│
├── .vscode/
|  └── settings.json
├── dashboard/
|  ├── dashboard.py
|  └── theme_config.py
├── docs/
|  ├── DATA_COLLECTION_GUIDE.md
|  ├── DEPLOYMENT.md
|  ├── INSTALL.md
|  └── QUICKSTART.md
├── evaluation/
|  └── evaluation.py
├── models/
|  └── models.py
├── pipeline/
|  ├── data_collection.py
|  ├── data_preprocessing.py
|  └── train_pipeline.py
├── prediction/
|  └── predict.py
├── reporting/
|  └── report_generator.py
├── scripts/
|  └── run.sh
├── app.py
├── .gitignore
├── README.md
├── requirements_streamlit.txt
├── requirements.txt
└── runtime.txt


```
## Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    DATA COLLECTION                          │
│  Open-Meteo API + DEFRA Network → raw_data.csv              │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│                   DATA PREPROCESSING                        │
│  Missing Values → Outliers → Features → Normalization       │
│                    processed_data.csv                       │
└────────────────────┬────────────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
┌──────────────┐ ┌──────────┐ ┌──────────────────┐
│ Random Forest│ │  LSTM    │ │ Hybrid CNN-LSTM  │
│   Model      │ │  Model   │ │     Model        │
└──────┬───────┘ └────┬─────┘ └────────┬─────────┘
       │              │               │
       └──────────────┼───────────────┘
                      │
                      ▼
         ┌────────────────────────────┐
         │  MODEL EVALUATION          │
         │  MSE, RMSE, MAE, R²        │
         │  evaluation_report.json    │
         └────────────────────────────┘
                      │
                      ▼
         ┌────────────────────────────┐
         │   PREDICTIONS & ALERTS     │
         │  Air Quality Level         │
         │  Recommendations           │
         └────────────────────────────┘

---

```
## Notes

- Data is generated using a realistic DEFRA-style simulation when live API access is unavailable. Results are seeded per city for reproducibility.
- Model training uses pre-configured architectures; no external dataset download is required to run the app.
- Reports are saved locally and offered as a download directly from the app.

---
