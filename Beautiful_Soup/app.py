# save this as app.py
import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("books_scraped.csv")

st.title("📚 Books to Scrape Dashboard")

st.write("Average Price by Rating")
avg_price = df.groupby("Rating")["Price"].mean()
st.bar_chart(avg_price)

st.write("Book Price Distribution")
fig, ax = plt.subplots()
ax.hist(df["Price"], bins=20)
st.pyplot(fig)
