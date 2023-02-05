PART 1. DBT SNAPSHOTS
Which orders changed from week 3 to week 4?
3 orders were shipped:
    df91aa85-bfc7-4c31-93ef-4cee8d00a343
    841074bf-571a-43a6-963c-ba7cbdb26c85
    0e9b8ee9-ad0a-42f4-a778-e1dd3e6f6c51

Query:
    select distinct(order_id)
    from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.ORDERS_SNAPSHOT
    where left(DBT_VALID_TO,10) > '2023-01-30'

PART 2. MODELING CHALLENGE
I have created fact table mart_product/fct_user_product_sessions to create product funnel dashboard which allows to analyze product funnel both from user and/or product perspective.
https://app.sigmacomputing.com/corise-dbt/workbook/workbook-3GWJF5EovJbzVDvHVW773u?:draftId=5ecebd11-865a-4282-a57f-ba7cafb84f71

In relation to this dashboard I have created exposures.yml.

3A. DBT NEXT STEPS FOR YOU
Our organization plans to implement DBT to its data stack, it would be ran within Keboola ETL environment. The main reason / benefit of implementing DBT are data testing as well as macros - those two will help to improve our work a lot.

3B. Setting up for production / scheduled dbt run of your project
We already have our data flow orchestrated within Keboola, so we will stick with Keboola, just implement DBT steps in between in order to test data and benefit from macros, fully understand data/tables relations thru DAG and documentation.
