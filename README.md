# A/B Testing Analysis – Marketing Campaigns (Control vs. Test)
# Project Overview
This project presents an end-to-end A/B testing analysis of two marketing campaigns (Control vs. Test), combining Python, SQL, and Tableau to evaluate campaign performance from both a statistical and business perspective.
The objective is to determine whether observed performance differences between the campaigns are statistically significant and to understand how and why the campaigns differ across the marketing funnel.
# Dataset
The analysis is based on a real world marketing campaign dataset, containing daily performance metrics for two campaigns.
Each row represents one campaign on one day and includes:
* Campaign Name: The name of the campaign
* Date: Date of the record
* Spend: Amount spent on the campaign in dollars
* of Impressions: Number of impressions the ad crossed through the campaign
* Reach: The number of unique impressions received in the ad
* of Website Clicks: Number of website clicks received through the ads
* of Searches: Number of users who performed searches on the website
* of View Content: Number of users who viewed content and products on the website
* of Add to Cart: Number of users who added products to the cart
* of Purchase: Number of purchases
# Data Preparation (Python)
Data preparation and validation were performed in Python and include:
* Loading and merging Control and Test datasets.
* Date conversion and column renaming.
* Handling missing values while maintaining A/B symmetry.
* Sanity checks:
  * Duplicate rows.
  * Negative values.
  * Logical consistency between funnel stages.
* Verification that both campaigns ran over the same time period.
  
The cleaned dataset is used for both SQL analysis and Tableau visualization.
# Statistical Analysis (Python)
A statistical hypothesis test was conducted to evaluate whether the difference in campaign performance is statistically significant.

Hypotheses:
* H₀ (Null Hypothesis): There is no difference in the mean number of purchases between the Control and Test campaigns.
* H₁ (Alternative Hypothesis): There is a significant difference in the mean number of purchases between the campaigns.


Method:
* Independent two-sample t-test (Welch’s t-test).
* Significance level: α = 0.05.

Result:

The p-value was greater than 0.05, therefore:
* The null hypothesis was not rejected.
* There is no statistically significant difference in average purchases between the campaigns.

# SQL Analysis
SQL was used to perform deeper business and funnel analysis based on the cleaned dataset.

Key SQL Analysis Areas:
1. Data validation and consistency checks.
2. Campaign-level totals and daily counts:
   
<img width="865" height="63" alt="image" src="https://github.com/user-attachments/assets/f41c84b7-0b69-4e1f-a1dc-a4115449de9b" />


Key Conclusions:
* The Control Campaign performed slightly better than the Test Campaign in terms of purchases. It generated 15,161 purchases compared to 14,869 purchases for the Test Campaign. This suggests that even though the campaigns showed different engagement patterns and traffic volumes, the Control Campaign was more effective at converting users into actual buyers.
* The Test Campaign spent more overall budget but did not generate a higher number of purchases. This indicates lower cost efficiency, as more spend was required to achieve   similar results. In other words, the Test Campaign was more expensive without delivering proportional value.
* While the Test Campaign drove more website clicks and searches, this higher level of engagement did not translate into increased purchases. This suggests that the issue     may be related to traffic quality rather than traffic quantity: the campaign attracted users, but not users with strong purchase intent.
* The Control Campaign shows stronger performance in the lower funnel. It generates more add-to-cart events and purchases relative to exposure, indicating a smoother and      more effective conversion journey.
* In contrast, the Test Campaign appears to lose users in later funnel stages. This may point to a mismatch between targeting and purchase intent, or possible friction        within the conversion process.
* Overall, the Control Campaign not only reached a larger audience but also converted more efficiently. This balance between reach and conversion efficiency highlights the    Control Campaign’s stability and reliability.
  
3. Average Reach, Clicks & Impressions
<img width="868" height="106" alt="image" src="https://github.com/user-attachments/assets/db2d4423-1400-4782-9382-9d911551e469" />

Key Conclusions:
* The Control Campaign reached a much larger audience and generated higher average daily reach and impressions. It focused mainly on broad exposure and making sure as many    people as possible saw the ads.
* The Test Campaign, on the other hand, reached fewer people but generated more website clicks on average. This suggests that while fewer users were exposed to the            campaign, those who did see it were more likely to interact with it.
* Even with lower impressions, the Test Campaign managed to drive more clicks per day. This points to stronger engagement at the top of the funnel and suggests that the       campaign’s messaging or targeting was more effective in encouraging users to take action.
* Overall, higher reach and impressions in the Control Campaign did not automatically lead to higher engagement. This highlights a clear tradeoff between exposure and  interaction: the Control Campaign prioritized scale, while the Test Campaign was more effective at driving user engagement among a smaller audience.

4. Cost efficiency metrics:
   * CPA (Cost Per Acquisition)
     <img width="805" height="141" alt="image" src="https://github.com/user-attachments/assets/484c135f-4341-4272-80c5-9b7ba7708417" />

      Key Conclusions:

      * The Control Campaign performed better in terms of cost efficiency, with a lower CPA of 4.41 compared to 5.02 for the Test Campaign. This means that each purchase in         the Control Campaign required less advertising spend, making it more efficient from a cost perspective.
     *  Although the Test Campaign had higher overall spend, it generated fewer purchases. As a result, the cost per acquisition increased, indicating that additional               budget did not translate into proportional business results. 
     *  The higher CPA of the Test Campaign suggests it would be more expensive to maintain without delivering better outcomes.
     *  The Control Campaign also shows more stable and predictable performance, making it a safer option for budget allocation.
     *  Before scaling, the Test Campaign would require further optimization, such as improvements in targeting, messaging, or the conversion flow.

  * CPC (Cost Per Click)
    
    <img width="752" height="139" alt="image" src="https://github.com/user-attachments/assets/f54ed665-f677-4076-a0c5-c4d728b8cde9" />

      Key Conclusions:
      *  The Test Campaign achieved a slightly lower cost per click (0.426) compared to the Control Campaign (0.433). This indicates that the Test Campaign was marginally            more efficient at driving users to click on the ads.
      *  The higher number of clicks suggests that the Test Campaign’s targeting or creative approach was effective at encouraging initial user interaction with the website.
      *  However, this advantage at the click level did not translate into stronger conversion performance or a lower cost per acquisition. While the Test Campaign was               successful in generating clicks, it was less effective at turning those clicks into purchases.
      *  Overall, the Test Campaign shows promise in top of funnel optimization. However, without improvements in downstream conversion stages, a lower CPC alone is not              sufficient to justify higher advertising spend.

    * Conversion rate

      <img width="865" height="132" alt="image" src="https://github.com/user-attachments/assets/2e4c989b-bdf4-4f81-a438-9aa004f55d36" />

      Key Conclusions:
      * The Control Campaign was more effective at converting users into buyers. Even with lower total spend, it generated more purchases than the Test Campaign, indicating         a stronger ability to turn website traffic into actual conversions. Users exposed to the Control Campaign were more likely to complete a purchase.
      * The Test Campaign, despite higher investment, did not achieve a proportional increase in conversions. This suggests that increasing spend alone does not lead to             better conversion outcomes when the rest of the funnel is not performing effectively.
      * Overall, the Control Campaign appears to attract higher-quality traffic, with fewer users dropping off before completing a purchase. In contrast, the Test Campaign          tends to attract users who show initial interest but convert less effectively in later funnel stages.
      * As a result, the Control Campaign provides more reliable and cost-effective growth.

    * CTR, View Content Rate, Add To Cart Rate, Purchase Rate

        <img width="865" height="115" alt="image" src="https://github.com/user-attachments/assets/a2dc28e0-e259-47c8-a63a-11287dcf5705" />

         Key Conclusions:
         * The Test Campaign achieved a significantly higher CTR (0.082) compared to the Control Campaign (0.049). This indicates that the Test Campaign’s messaging or                 targeting was more effective at attracting initial user interest. At the awareness and engagement stage, the Test Campaign clearly outperformed the Control                  Campaign.
         * The Control Campaign shows a higher View Content Rate (0.365 vs. 0.313). This suggests that users who clicked on the Control Campaign were more inclined to                  explore the product content.
         * While the Test Campaign attracted more clicks, the Control Campaign delivered more qualified traffic.
         * The Control Campaign significantly outperformed the Test Campaign in Add-to-Cart rate (0.669 vs. 0.464). This indicates stronger purchase intent and better                  alignment between the ad and the product offering.
         * The Control Campaign performs notably better in encouraging users to take a decisive step toward purchase.
         * The Test Campaign achieved a higher Purchase Rate (0.583 vs. 0.402). This suggests that among users who reached the purchase stage, the Test Campaign was more               effective at closing the transaction. However, this strength applies to a smaller and less consistent subset of users, given weaker performance in earlier lower-            funnel stages.
         * The Test Campaign excels at the top of the funnel, generating strong interest and clicks.
         * The Control Campaign is stronger through the middle and lower funnel, particularly in driving add-to-cart actions.
         * The Test Campaign shows a less stable funnel, with strong entry but significant drop-off before cart actions.

  5. Daily performance analysis and trend evaluation

     <img width="865" height="311" alt="image" src="https://github.com/user-attachments/assets/def2f692-ba05-4991-8875-b14718ab8d12" />

      Key Conclusions:
      * The highest daily conversion rates were achieved by the Control Campaign, with a peak value of 0.322. This indicates that on its best-performing days, the Control           Campaign was significantly more effective at converting clicks into purchases. The Control Campaign demonstrates stronger peak performance potential.
      * The Control Campaign appears more frequently among the top-performing days, suggesting greater consistency in conversion performance. The Test Campaign appears less         often and mainly in mid-range conversion values.
      * Consistency is critical for scalable and reliable campaign performance.
      * Several Test Campaign days show high click volumes but lower conversion rates. In contrast, Control Campaign days with fewer clicks often achieved higher conversion        rates. This reinforces the insight that traffic quality matters more than traffic quantity.
      * Control Campaign days consistently show stronger conversion efficiency, even when click volume is moderate. This suggests better alignment between targeting,                messaging, and purchase intent. The Control Campaign performs better in the lower funnel, where business value is realized.
      * The Test Campaign exhibits greater variability, with fewer standout high-conversion days.This variability introduces higher risk when allocating larger budgets.


     <img width="865" height="451" alt="image" src="https://github.com/user-attachments/assets/48968a7e-54ae-477c-91a1-7ab00b1d1880" />

      Key Conclusions:
      * Across multiple days, the Control Campaign exhibits low CTR values (often below 0.04).Despite this, the Add-to-Cart rate is extremely high, in some cases exceeding          1.0. This indicates that although relatively few users clicked on the ads, those who did were highly purchase-oriented.
      * The Control Campaign dominates the list of high Add-to-Cart days.Several days show Add-to-Cart rates above 100%, suggesting:
         * Repeat add-to-cart actions
         * Or very strong alignment between product content and user intent
        This points to high-intent, well-targeted traffic, even with limited exposure.
      * The Control Campaign appears to prioritize intent over volume:
         * Fewer clicks
         * Strong downstream actions
        In contrast, the Test Campaign appears only once in this list and with a much lower Add-to-Cart rate. This reinforces the pattern that the Test Campaign drives              engagement, while the Control Campaign drives meaningful purchase behavior.
      * The repeated appearance of the Control Campaign across many days suggests stable lower-funnel performance. Such consistency is valuable for scaling campaigns with           predictable outcomes.


     <img width="788" height="159" alt="image" src="https://github.com/user-attachments/assets/1e110618-96e4-4a1b-bb58-4a79bbaa05d4" />

     Key Conclusions:
     * The Control Campaign reached its highest number of impressions on August 14, 2019, with 145,248 impressions.
     * The Test Campaign peaked on August 21, 2019, with 133,771 impressions.
     * The Control Campaign had a slightly higher peak in impressions compared to the Test Campaign, which may have contributed to greater visibility or engagement on that       day.








        



      


