
select *
from ab_data_for_analysis;


# Checking that each date appears exactly once per campaign
select  `Date`, count(date) as count_date_per_campaign
from ab_data_for_analysis
group by `Date`;

# Checking for missing values
select *
from ab_data_for_analysis
where Campaign_name is null
      or `Date` is null
      or Spend_usd is null
      or Impressions is null
      or Reach is null
      or Website_clicks is null
      or Searches is null
      or View_content is null
      or Add_to_cart is null
      or Purchase is null;

# Checking for negative values
select *
from ab_data_for_analysis as ab
where ab.Spend_usd < 0
      or ab.Impressions < 0
      or ab.Reach < 0 
      or ab.Website_clicks < 0
      or ab.Searches < 0
      or ab.View_content < 0
      or ab.Add_to_cart < 0
      or ab.Purchase < 0;
      
# Checking for duplicates
with duplicate_cte as 
(
  select *,
  row_number() over (partition by Campaign_name, `Date`, Spend_usd, Impressions, Website_clicks, Searches,
                     View_content, Add_to_cart, Purchase) as row_num
  from ab_data_for_analysis
)
select *
from duplicate_cte
where row_num > 1;



# KPI
select Campaign_name,
round(sum(Spend_usd) / sum(Website_clicks),3) as CPC, 
round(sum(Spend_usd) / sum(Purchase),3) as CPA,
round(sum(Website_clicks) / sum(Impressions),3) as CTR,
round(sum(Purchase) / sum(Website_clicks),3) as Purchase_Conversion_Rate,
round(sum(View_content) / sum(Website_clicks),3) as View_Content_Rate,
round(sum(Purchase) / sum(Add_to_cart),3) as Add_To_Cart_Purchase_Rate
from ab_data_for_analysis
group by Campaign_name;

 
# Number of days recorded
select Campaign_name, 
year(`Date`) as Campaign_Year,
month(`Date`) as Campaign_Month,
count(*) as total_days
from ab_data_for_analysis
group by Campaign_name, year(`Date`), month(`Date`)
order by Campaign_name, Campaign_Year, Campaign_Month;

# Campaign performance totals
select Campaign_name,
sum(Purchase) as total_purchase,
sum(Spend_usd) as total_spend,
sum(Impressions) as total_impressions,
sum(Reach) as total_reach,
sum(Website_clicks) as total_clicks,
sum(Searches) as total_searches,
sum(View_content) as total_views,
sum(Add_to_cart) as total_add_to_cart
from ab_data_for_analysis
group by Campaign_name;

# Average Reach, Website Clicks and Impressions
select Campaign_name,
round(avg(Reach),3) as avg_reach,
round(avg(Website_clicks),3) as avg_website_clicks,
round(avg(Impressions),3) as avg_impressions
from ab_data_for_analysis
group by Campaign_name;

# Cost efficiency
select Campaign_name,
sum(Spend_usd) as total_spend,
sum(Purchase) as total_purchase,
round(sum(Spend_usd) / sum(Purchase), 3) as CPA
from ab_data_for_analysis
group by Campaign_name;

select Campaign_name,
sum(Spend_usd) as total_spend,
sum(Website_clicks) as total_clicks,
round(sum(Spend_usd) / sum(Website_clicks), 3) as CPC
from ab_data_for_analysis
group by Campaign_name;

# Conversion / Funnel
select Campaign_name,
sum(Spend_usd) as total_spend,
sum(Purchase) as total_purchase,
round(sum(Spend_usd) / sum(Purchase) , 3) as conversion_rate
from ab_data_for_analysis
group by Campaign_name;

select Campaign_name,
round(sum(Website_clicks) / sum(Impressions), 3) as CTR,
round(sum(View_content) / sum(Website_clicks), 3) as view_content_rate,
round(sum(Add_to_cart) / sum(View_content), 3) as add_to_cart_rate,
round(sum(Purchase) / sum(Add_to_cart), 3) as purchase_rate
from ab_data_for_analysis
group by Campaign_name;

# Outliers & interesting days
with daily_conversion_rate as(
     select Campaign_name,
     `Date`,
     ab.Purchase,
     ab.Website_clicks,
     round(ab.Purchase / ab.Website_clicks, 3) as conversion_rate
     from ab_data_for_analysis as ab
)
select * 
from daily_conversion_rate
where conversion_rate > 0.15
order by conversion_rate desc;

select Campaign_name,
`Date`,
round(ab.Website_clicks / ab.Impressions, 3) as daily_CTR,
round(ab.Add_to_cart / ab.View_content, 3) as daily_Add_To_Cart_Rate
from ab_data_for_analysis as ab
where round(ab.Website_clicks / ab.Impressions, 3) < 0.05 and
round(ab.Add_to_cart / ab.View_content, 3) > 0.6;

with max_impressions as(
   select Campaign_name,
   max(Impressions) as max_imp
   from ab_data_for_analysis
   group by Campaign_name
)
select ab.Campaign_name,
ab.`Date`,
ab.Impressions
from ab_data_for_analysis as ab
join max_impressions as m
   on ab.Campaign_name = m.Campaign_name
   and ab.Impressions = m.max_imp
order by ab.Campaign_name;