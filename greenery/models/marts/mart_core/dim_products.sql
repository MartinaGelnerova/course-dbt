with products as (
    select *
    from {{ref('stg_postgres__products')}}
)

, order_items as (
    select product_guid
        , count(distinct(order_guid)) as orders_count
        , sum(quantity) as pcs_sold
    from {{ref('stg_postgres__order_items')}}
    group by 1
)

select
    distinct(p.product_guid) as product_guid
    , p.name
    , p.price
    , p.inventory
    , oi.orders_count
    , oi.pcs_sold
    , round(oi.pcs_sold / oi.orders_count,2) as avg_pcs_per_order
from products p
left join order_items oi
    on p.product_guid = oi.product_guid