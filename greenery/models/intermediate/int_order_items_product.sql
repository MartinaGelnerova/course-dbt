{{
    config(
        MATERIALIZED = 'table'
    )
}}

with products as (
    select *
    from {{ref('stg_postgres__products')}}
),
order_items as (
    select *
    from {{ref('stg_postgres__order_items')}}
),

orders as (
    select
        order_guid
        , user_guid
        , created_at_utc
    from {{ref('stg_postgres__orders')}}
)

select
    oi.order_guid
    , oi.product_guid
    , o.user_guid
    , o.created_at_utc
    , p.name as product_name
    , oi.quantity
    , p.price
    , price * quantity as order_revenue
from order_items oi
left join orders o
    on oi.order_guid = o.order_guid
left join products p
    on oi.product_guid = p.product_guid