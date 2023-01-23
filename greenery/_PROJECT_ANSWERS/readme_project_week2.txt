
PART 1. MODELS
WHAT IS OUR USER REPEAT RATE?
    Repeat Rate = Users who purchased 2 or more times / users who purchased
    0.798387

SQL QUERY:
    with user_orders as (
    SELECT 
        user_guid
        , count(distinct(order_guid)) as no_of_orders
    from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.STG_POSTGRES__ORDERS
    group by 1)
    select
        sum((no_of_orders >= 2)::int) as users_with_two_plus_orders
        , sum ((no_of_orders >=1)::int) as users_with_orders
        , users_with_two_plus_orders / users_with_orders as repeat_rate
    from user_orders

EXPLAIN THE MARTS MODELS YOU ADDED. WHY DID YOU ORGANIZE THE MODELS IN THE WAY YOU DID?
I have prepared several intermediate models to which I cross-refer at mart models.
Core - this was the hardest part - decide what to include and what not. I just tried to figure out various combination of information needed for future reports.
Marketing - as per suggestions, I have included aggregated information per user related to its shopping behaviour (first/last order date, number of orders, total revenue).
Product - again as per suggetions, there is an aggregated daily information per product related to page views and view conversion to order (number of page views and orders, conversion rate, pieces sold).

PART 2. TESTS
Honestly did not have time to work on anything more sophisticated than -not_null and -unique. Will work on this part later on.
As for BAD DATA - to my surprise there have been some, yeah! We do not have unique product_guid in 
    Failure in test unique_dim_products_product_guid (models/marts/mart_core/_mart_core_models.yml)
    20:41:15    Got 30 results, configured to fail if != 0
    20:41:15  
    20:41:15    compiled Code at target/compiled/greenery/models/marts/mart_core/_mart_core_models.yml/unique_dim_products_product_guid.sql
I found out I forgot to add keys to left join in dim_products.sql. Corrected now, so no more errors...

PART 3. DBT SNAPSHOTS
WHICH ORDERS CHANGED FROM WEEK 1 TO WEEK 2?

    order_id_that_changed
    265f9aae-561a-4232-a78a-7052466e46b7
    e42ba9a9-986a-4f00-8dd2-5cf8462c74ea
    b4eec587-6bca-4b2a-b3d3-ef2db72c4a4f

SQL QUERY:
    select distinct(order_id)   as order_id_that_changed
    from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.ORDERS_SNAPSHOT
    where dbt_valid_to is not null --plus there should be some date/time limitation