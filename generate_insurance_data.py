import pandas as pd
import numpy as np

print("=" * 50)
print("Generating Homeowners Insurance Data")
print("=" * 50)

# Generate 1000 homes
n_homes = 1000
np.random.seed(42)

data = {
    'home_id': range(1, n_homes + 1),
    'home_value': np.random.uniform(150000, 800000, n_homes).round(0),
    'home_age': np.random.randint(0, 50, n_homes),
    'square_feet': np.random.randint(800, 5000, n_homes),
    'bedrooms': np.random.randint(1, 6, n_homes),
    'bathrooms': np.random.uniform(1, 4.5, n_homes).round(1),
    'claims_history': np.random.poisson(0.3, n_homes),
    'flood_zone': np.random.choice([0, 1], n_homes, p=[0.85, 0.15]),
    'burglary_rate': np.random.uniform(0, 0.15, n_homes).round(3),
    'construction_type': np.random.choice(['Brick', 'Wood', 'Concrete'], n_homes, p=[0.5, 0.3, 0.2]),
    'credit_score': np.random.normal(700, 50, n_homes).clip(300, 850).round(0),
    'distance_to_fire_station': np.random.uniform(0.5, 10, n_homes).round(1)
}

df = pd.DataFrame(data)

# Calculate risk score
df['risk_score'] = (
    (df['home_age'] / 50 * 20) +
    (df['claims_history'] * 15) +
    (df['flood_zone'] * 25) +
    (df['burglary_rate'] * 200) +
    (df['distance_to_fire_station'] / 10 * 10)
).clip(0, 100).round(1)

# Calculate annual premium
df['annual_premium'] = (500 + df['risk_score'] * 15 + df['home_value'] * 0.0005).round(2)

# Add claim indicator
df['had_claim'] = (df['claims_history'] + np.random.poisson(0.2, n_homes) > 0.5).astype(int)

# Save to CSV
df.to_csv('homeowner_insurance_data.csv', index=False)

print(f"\n✅ Generated {n_homes} records")
print(f"✅ Saved to: homeowner_insurance_data.csv")
print(f"\nFirst 5 rows:")
print(df.head())
print(f"\nColumns: {list(df.columns)}")
print(f"\nData range:")
print(f"  Home Value: ${df['home_value'].min():,.0f} - ${df['home_value'].max():,.0f}")
print(f"  Risk Score: {df['risk_score'].min():.1f} - {df['risk_score'].max():.1f}")
print(f"  Premium: ${df['annual_premium'].min():,.0f} - ${df['annual_premium'].max():,.0f}")