with product_views as (
    select
        product_guid
        , created_at_utc::date as date
        , sum(iff(event_type = 'page_view', 1, 0)) as page_views
    from {{ref('stg_postgres__events')}}
    where product_guid is not null
    group by 1, 2)

, product_orders as (
    select
        product_guid
        , created_at_utc::date as date
        , count(distinct(order_guid)) as count_orders
        , sum(quantity) as pcs_sold
        , round(pcs_sold / count_orders,2) as avg_pcs_per_order
    from {{ref('int_order_items_product')}}
    group by 1,2
)

select
    pv.product_guid
    , pv.date
    , pv.page_views
    , zeroifnull(po.count_orders) as orders_count
    , round(div0(orders_count, pv.page_views),2) as view_order_conversion
    , coalesce(po.pcs_sold,0) as pcs_sold
    , coalesce(po.avg_pcs_per_order,0) as avg_pcs_per_order
from product_views pv
left join product_orders po
    on pv.product_guid = po.product_guid
        and pv.date = po.date