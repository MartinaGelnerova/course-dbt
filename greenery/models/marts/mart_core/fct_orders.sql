with orders as (
    select *
    from {{ref('stg_postgres__orders')}}
)

, order_items as (
    select
        order_guid
        , count(distinct(product_guid)) as diff_products
        , sum(quantity) as total_items
    from {{ref('int_order_items_product')}}
    group by 1
)

select
    o.order_guid
    , o.user_guid
    , o.created_at_utc
    , o.order_cost
    , o.shipping_cost
    , o.order_cost + o.shipping_cost as order_total_cost
    , o.shipping_service
    , o.estimated_delivery_at_utc
    , o.delivered_at_utc
    , o.status
    , oi.diff_products
    , oi.total_items
    , datediff('day',created_at_utc, delivered_at_utc) as time_to_delivery
    , datediff('hour',estimated_delivery_at_utc, delivered_at_utc) as delivery_delay
from orders o
left join order_items oi
    on o.order_guid = oi.order_guid