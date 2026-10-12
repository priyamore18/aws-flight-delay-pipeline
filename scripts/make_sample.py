
import pandas as pd

df = pd.read_csv("data/flights.csv", nrows=200000, low_memory=False)

df.to_csv("data/flights_sample.csv", index=False)

print(df.shape)
print(df.columns.tolist())

