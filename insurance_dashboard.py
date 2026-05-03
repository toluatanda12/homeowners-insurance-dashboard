import streamlit as st
import pandas as pd
import numpy as np
import os
import plotly.express as px

st.set_page_config(page_title="Homeowners Insurance Dashboard", layout="wide")

st.title("Homeowners Insurance Risk Dashboard")

if not os.path.exists("homeowner_insurance_data.csv"):
    st.error("CSV file not found. Please run generate_data.py first.")
    st.stop()

@st.cache_data
def load_data():
    df = pd.read_csv("homeowner_insurance_data.csv")
    return df

df = load_data()

st.sidebar.header("Quote Calculator")

col1, col2 = st.columns(2)

with col1:
    st.subheader("Enter Home Details")
    home_value = st.number_input("Home Value ($)", min_value=50000, max_value=2000000, value=350000, step=10000)
    home_age = st.slider("Home Age (years)", 0, 100, 15)
    flood_zone = st.selectbox("Flood Zone", ["No", "Yes"])
    flood_value = 1 if flood_zone == "Yes" else 0
    
with col2:
    st.subheader("Risk Factors")
    claims_history = st.number_input("Prior Claims", min_value=0, max_value=10, value=0, step=1)
    distance_fire = st.slider("Distance to Fire Station (miles)", 0.5, 10.0, 2.5, 0.5)
    credit_score = st.slider("Credit Score", 300, 850, 720)
    construction = st.selectbox("Construction Type", ["Brick", "Wood", "Concrete"])

risk_score = (home_age / 50) * 20
risk_score += claims_history * 15
risk_score += flood_value * 25
risk_score += (distance_fire / 10) * 10
risk_score += ((850 - credit_score) / 550) * 10

if construction == "Wood":
    risk_score += 10
elif construction == "Concrete":
    risk_score -= 5

risk_score = max(0, min(100, risk_score))

premium = 400 + (risk_score * 12) + (home_value * 0.0004)
if construction == "Wood":
    premium += 150

st.subheader("Your Results")

col3, col4, col5 = st.columns(3)

with col3:
    if risk_score < 30:
        st.metric("Risk Score", f"{risk_score:.1f}", delta="Low Risk", delta_color="normal")
    elif risk_score < 70:
        st.metric("Risk Score", f"{risk_score:.1f}", delta="Medium Risk", delta_color="off")
    else:
        st.metric("Risk Score", f"{risk_score:.1f}", delta="High Risk", delta_color="inverse")

with col4:
    st.metric("Estimated Annual Premium", f"${premium:,.2f}")

with col5:
    claim_prob = (risk_score / 100) * 0.3
    st.metric("Claim Probability", f"{claim_prob:.1%}")

st.divider()

st.subheader("Data Analysis")

tab1, tab2, tab3 = st.tabs(["Premium Distribution", "Risk Analysis", "Flood Zone Comparison"])

with tab1:
    fig = px.histogram(df, x="annual_premium", nbins=30, title="Distribution of Annual Premiums")
    fig.update_layout(xaxis_title="Annual Premium ($)", yaxis_title="Number of Homes")
    st.plotly_chart(fig)

with tab2:
    risk_by_flood = df.groupby("flood_zone")["risk_score"].mean()
    risk_by_flood.index = ["Non-Flood", "Flood Zone"]
    st.bar_chart(risk_by_flood)

with tab3:
    premium_by_flood = df.groupby("flood_zone")["annual_premium"].mean()
    premium_by_flood.index = ["Non-Flood", "Flood Zone"]
    st.bar_chart(premium_by_flood)

st.sidebar.divider()
st.sidebar.subheader("Summary Statistics")
st.sidebar.write(f"Total Records: {len(df):,}")
st.sidebar.write(f"Avg Premium: ${df['annual_premium'].mean():,.2f}")
st.sidebar.write(f"Claim Rate: {df['had_claim'].mean():.1%}")
st.sidebar.write(f"Flood Zone Homes: {df['flood_zone'].sum():,} ({df['flood_zone'].mean():.1%})")