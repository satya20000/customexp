# Power BI build package

No Power BI Desktop was run. No .pbix or Power BI screenshot is claimed. Python previews are labeled explicitly.

## Import and types
Create a text parameter `DataFolder` pointing to 02_Cleaned_Data. Create function `LoadTable` from power_query.m. For every cleaned CSV create a query `LoadTable("fact_lead")`, replacing the table name. All CSVs are final cleaned exports, not raw data; major transformations live in Python. Apply types from column_types.json; parse dates with locale en-US. Hide row keys. Set numerical attributes to Do not summarize unless measures are used. Mark dim_date as date table.

## Relationships
Use relationships.csv. Single-direction filters only. Verify one-side uniqueness before activation.

Orders flow to the bridge, not back to fact_order. Use Bridge Orders/Bridge Late Rate/Bridge Review Score on seller/category visuals to project distinct bridge order IDs through TREATAS. Never sum order counts, delays or reviews over bridge rows. Overall cards include itemless orders and cancellations; seller/category cards cover orders with item membership. Configure seller/category selections to interact only with bridge measures. Review scores apply to orders, not uniquely to an individual seller.

## Layout and interactions
Each page is 1280 x 720, white background, 24 px margins. Header at y=20, page title 24 pt. At most 5 KPI cards in a 96 px row. Use two or three charts below; axes 11 pt minimum. Synced slicers on left for dates and relevant dimension. Add denominator and coverage tooltips to rates. Chart selections cross-filter charts on the same page. Provide reset filters bookmark and accessible alt text. No red/green-only encoding. Use Top N 15 plus detail drillthrough rather than overcrowded bars.

## Page and visual specifications

### Customer Experience Overview

| Visual | DAX measures | Business question | Source/axis |
|---|---|---|---|
| KPI cards | Total Orders; On Time Delivery Rate; Average Delivery Days; Average Review Score; Cancellation Rate | What was overall delivery and review performance? | fact_order |
| Line | Late Delivery Rate; Average Review Score | When did experience deteriorate? | dim_date[month] |
| Bar | Total Orders | Which order statuses dominate? | fact_order[order_status] |

### Delivery Performance

| Visual | DAX measures | Business question | Source/axis |
|---|---|---|---|
| Line | Average Processing Days; Average Shipping Days | Which stage is longer over time? | dim_date[month] |
| Bar | Late Delivery Rate | Which customer states have delivery issues? | dim_customer[customer_state] |
| Column | Total Orders | How large are delay bands? | fact_order[delay_band] |

### Customer Satisfaction

| Visual | DAX measures | Business question | Source/axis |
|---|---|---|---|
| Column | Reviewed Orders | What is the review distribution? | fact_order[review_score] |
| Bar | Average Review Score; One Star Rate | How do reviews differ by delay band? | fact_order[delay_band] |
| Bar | Bridge Review Score | Which categories have low reviewed-order scores? | dim_category[category] |

### Root Cause and Seller Performance

| Visual | DAX measures | Business question | Source/axis |
|---|---|---|---|
| Matrix | Bridge Orders; Bridge Late Rate; Bridge Review Score | Which sellers warrant investigation? | dim_seller[seller_id] |
| Matrix | Bridge Processing Days; Bridge Shipping Days | Is a route issue before or after handoff? | bridge_order_seller_category[seller_state] and dim_customer[customer_state] |
| Bar | Bridge Late Rate | Which categories warrant a matched-route comparison? | dim_category[category] |

## Acceptance checks
Match all unfiltered cards to 03_SQL/results/portfolio_kpis.csv (KKBOX uses monthly_subscription.csv). Test a single dimension, two combined filters and an empty selection. Verify rates recalculate from numerator/denominator, rather than mean of group rates. For CX compare distinct orders before/after bridge selection. For loans active outcomes must stay out of default denominators. Drillthrough to underlying rows and reset filters. DAX and Power Query assets have not been executed in Power BI Desktop.
