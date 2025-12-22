import pandas as pd
from scipy import stats

pd.options.display.max_rows = None
pd.options.display.max_columns = None


control_group = pd.read_csv("data/control_group.csv", sep=";")
test_group = pd.read_csv("data/test_group.csv", sep=";")


df = pd.concat([control_group, test_group], ignore_index=True) # combine the 2 database
print(df) # Checking that the concat works.
df.info()
print(df.shape) # Number of rows: 60. Number of columns: 10.
# The date column is on type object. I will change it to a date format.
df["Date"] = pd.to_datetime(df["Date"], dayfirst=True)
print(df[["Campaign Name","Date"]])
# Both campaigns were carried out over the same date range and on the same number
# of observations per group. This is important because there was no effect of
# seasonality, no effect on daily differences, environmental conditions were the
# same for both groups.


# I want to rename the columns for more readable names.
df = df.rename(columns={'Campaign Name': 'Campaign_name',
                        'Spend [USD]': 'Spend_usd',
                        '# of Impressions': 'Impressions',
                        '# of Website Clicks': 'Website_clicks',
                        '# of Searches': 'Searches',
                        '# of View Content': 'View_content',
                        '# of Add to Cart': 'Add_to_cart',
                        '# of Purchase': 'Purchase'
                        })
print(df.head())

# Sanity and Data Cleaning:
print(df.isnull().sum())
# Most columns have only 1 missing value. I will check if the missing values are on the same row.
dfNA = df[df['Impressions'].isna()]
print(dfNA)
# All missing values are in the same row (row number 4).
# Because it's just one row with missing values, i'll delete it. But because this is
# an A/B test, I'll also delete the row with the same date (2019-08-05) in the second group.
# Since both groups must remain symmetrical in terms of time.
df = df.dropna()
print(df.isnull().sum())
df = df[df["Date"] != "2019-08-05"]

# Checking for duplicates:
print(df.duplicated().sum())
# No duplicates.

# Checking that each date has exactly two rows:
print(df.groupby("Date")["Campaign_name"].nunique().value_counts())
# There are 29 dates and each date has exactly 2 rows and that's what i wanted to get.

# Checking for negative values:
print((df[["Spend_usd", "Impressions", "Reach", "Website_clicks", "Searches",
  "View_content", "Add_to_cart", "Purchase"]] < 0).sum())
# No negative values.

# Checking logical logic between columns:
print((df["Reach"] > df["Impressions"]).sum())
print((df["Website_clicks"] > df["Impressions"]).sum())
print((df["Purchase"] > df["Website_clicks"]).sum())
# Everything came out 0, so there is no logic problem.

# Budget distribution check:
print(df.groupby("Campaign_name")["Spend_usd"].agg(["mean", "median", "std"]))
# The Test Campaign operated with approximately 12% higher daily budget then the
# Control Campaign, which may partially explain performance differences and therefore
# requires evaluation using normalized metrics.


# KPI Definitions:
# Primary KPI:
# Purchases

#Secondary KPIs:
# CTR (Website_clicks / Impressions)
# CPC (Spend_usd / Website_clicks)
# Click to Purchase Conversion Rate (Purchases / Website_Clicks)
# View Content Rate (View_Content / Website_Clicks)
# Add to Cart to Purchase Rate (Purchases / Add_to_Cart)
# CPA (Spend / Purchases)

# Hypotheses:
# H0: There is no difference in the mean number of purchases between Control and Test campaigns
# H1: There is a significant difference in the mean number of purchases between the campaigns

# Separation into groups
control = df[df["Campaign_name"] == "Control Campaign"]["Purchase"]
test = df[df["Campaign_name"] == "Test Campaign"]["Purchase"]

# Sample size test
# print(len(control), len(test))

t_stat, p_value = stats.ttest_ind(control, test, equal_var=False)
print(f"T-statistic: {t_stat}")
print(f"P-value: {p_value}")

# Significance level (alpha) = 0.05
# If p-value < alpha then reject H0
# If p-value >= alpha then fail to reject H0

# Result interpretation:
# The p-value is 0.8468, which is greater than 0.05.
# Therefore, I fail to reject the null hypothesis.
# There is no statistically significant difference in purchases between campaigns.

df.to_csv("AB_data_analysis.csv", index=False)