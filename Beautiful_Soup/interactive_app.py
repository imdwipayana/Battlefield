import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

# Load data
df = pd.read_csv("books_scraped.csv")

st.title("📚 Interactive Books Dashboard")

# Sidebar filters
st.sidebar.header("Filters")

# Rating filter
ratings = sorted(df["Rating"].dropna().unique())
selected_rating = st.sidebar.multiselect("Select Ratings:", ratings, default=ratings)

# Price range filter
min_price, max_price = int(df["Price"].min()), int(df["Price"].max())
price_range = st.sidebar.slider("Price range (£):", min_price, max_price, (min_price, max_price))

# Apply filters
filtered_df = df[
    (df["Rating"].isin(selected_rating)) &
    (df["Price"].between(price_range[0], price_range[1]))
]

# Display filtered table
st.write(f"Showing {len(filtered_df)} books")
st.dataframe(filtered_df)

# Charts
st.subheader("Average Price by Rating")
avg_price = filtered_df.groupby("Rating")["Price"].mean()
st.bar_chart(avg_price)

st.subheader("Price Distribution")
fig, ax = plt.subplots()
ax.hist(filtered_df["Price"], bins=20, color='skyblue', edgecolor='black')
st.pyplot(fig)
