with user_orders as (
    select *
    from {{ref('int_order_items_product')}}
)

select user_guid
    , min(created_at_utc::date) as first_order_date
    , max(created_at_utc::date) as last_order_date
    , count(distinct(order_guid)) as orders_count
    , sum(order_revenue) as total_revenue
from user_orders
group by 1