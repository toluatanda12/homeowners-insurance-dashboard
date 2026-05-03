
```markdown
# Homeowners Insurance Risk Dashboard

## Project Purpose

This project demonstrates a complete data science workflow for insurance risk analysis. It combines Python data generation, R statistical analysis, and an interactive Streamlit dashboard to help insurance underwriters and managers understand risk factors that drive premiums and claims.

The primary business goal is to identify whether flood zone homes are properly priced relative to their actual claim risk, and to provide actionable recommendations for improving portfolio profitability.

## Key Findings

- Flood zone homes pay 32% higher premiums ($404 more per year)
- Flood zone homes do NOT have significantly higher claim rates (41% vs 39%)
- Risk score and home value are the primary drivers of premium
- Construction type has no significant impact on premium or claims

## Technology Stack

| Component | Technology |
|-----------|------------|
| Data Generation | Python, Pandas, NumPy |
| Statistical Analysis | R, Tidyverse |
| Interactive Dashboard | Python, Streamlit, Plotly |
| Visualizations | Matplotlib, Plotly, ggplot2 |
| Version Control | Git, GitHub |

## Live Demo

View the interactive dashboard: [https://homeowners-insurance-dashboard-k4epgoauy2f2uvap67ssrv.streamlit.app/](https://homeowners-insurance-dashboard-k4epgoauy2f2uvap67ssrv.streamlit.app/)

## Repository File Structure

```
├── insurance_dashboard.py          # Main Streamlit dashboard
├── generate_insurance_data.py      # Python script to generate synthetic data
├── simple_analysis.R               # Basic R analysis (summary stats, histograms)
├── insurance_statistics.R          # Complete R analysis (all statistical tests)
├── requirements.txt                # Python dependencies
├── homeowner_insurance_data.csv    # Generated dataset (1,000 records)
├── README.md                       # This file
│
├── Images (R generated)
│   ├── premium_histogram.png       # Distribution of all premiums
│   ├── flood_comparison.png        # Boxplot: flood vs non-flood premiums
│   ├── ttest_bar_chart.png         # Bar chart: average premium by flood zone
│   ├── anova_bar_chart.png         # Bar chart: premium by construction type
│   ├── correlation_heatmap.png     # Heatmap of all variable correlations
│   ├── chi_square_chart.png        # Bar chart: claims by flood zone
│   ├── risk_score_distribution.png # Distribution of risk scores
│   └── regression_coefficients.png # Impact of each factor on premium
│
└── Output files
    ├── analysis_results.csv        # Summary statistics from R
    └── correlation_matrix.csv      # Full correlation matrix
```

## File Descriptions

### Python Files

| File | Description |
|------|-------------|
| `insurance_dashboard.py` | Streamlit web app with real-time quote calculator and interactive charts. Users input home details and receive instant risk score, premium estimate, and claim probability. |
| `generate_insurance_data.py` | Creates synthetic dataset of 1,000 homeowners with 15 risk factors including home value, age, flood zone, credit score, construction type, and claims history. Calculates risk scores and premiums using defined formulas. |

### R Scripts

| File | Description |
|------|-------------|
| `simple_analysis.R` | Basic exploratory analysis: summary statistics, premium distribution histogram, flood zone boxplot, and export of summary CSV. |
| `insurance_statistics.R` | Comprehensive statistical analysis including: t-test (flood zone premium comparison), ANOVA (construction type comparison), linear regression (factor importance), correlation matrix, chi-square test (flood zone vs claims), and generation of all visualization images. |

### Data Files

| File | Description |
|------|-------------|
| `homeowner_insurance_data.csv` | Main dataset with 1,000 records and 15 columns. Each row represents one homeowner with calculated risk score and premium. |
| `analysis_results.csv` | Summary statistics exported from R including averages by flood zone and construction type. |
| `correlation_matrix.csv` | Full correlation matrix of all numeric variables for further analysis in Excel. |

### Images (R Generated)

| File | Business Insight |
|------|------------------|
| `premium_histogram.png` | Shows premium distribution - most homes fall between $1,000-$1,600 |
| `flood_comparison.png` | Boxplot showing flood zone premiums are consistently higher |
| `ttest_bar_chart.png` | Flood zone homes pay 32% more on average ($1,654 vs $1,250) |
| `anova_bar_chart.png` | Construction type does not significantly affect premium |
| `correlation_heatmap.png` | Risk score and flood zone are most correlated with premium |
| `chi_square_chart.png` | Flood zone homes do not have statistically higher claim rates |
| `risk_score_distribution.png` | Most homes have low to medium risk scores (0-50) |
| `regression_coefficients.png` | Risk score and home value are the only direct premium drivers |

## Installation and Usage

### Prerequisites

- Python 3.8+
- R 4.0+
- Git

### Local Setup

1. Clone the repository:
```bash
git clone https://github.com/toluatanda12/homeowners-insurance-dashboard.git
cd homeowners-insurance-dashboard
```

2. Install Python dependencies:
```bash
pip install -r requirements.txt
```

3. Run the Streamlit dashboard:
```bash
streamlit run insurance_dashboard.py
```

4. (Optional) Run R analysis:
```bash
Rscript insurance_statistics.R
```

## Business Recommendations

Based on the statistical analysis:

1. **Maintain flood zone pricing** - This segment is profitable despite equal claim rates
2. **Adjust pricing by risk score** - Create tiered pricing for low, medium, and high risk scores
3. **Investigate non-flood segment losses** - Non-flood homes show higher than expected claim frequency
4. **Ignore construction type in pricing** - No significant impact on premiums or claims

## Future Enhancements

- Add Monte Carlo simulation for risk probability distributions
- Implement machine learning models (random forest, XGBoost) for claim prediction
- Add more risk factors (roof age, security system, prior claim amounts)
- Deploy dashboard to cloud permanently
- Add time-series analysis with policy renewal data

## Author

Tolulope Atanda


```
