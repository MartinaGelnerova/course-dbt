{{
    config(
        MATERIALIZED = 'table'
        )
}}

with
events as (
    select *
    from {{ ref('stg_postgres__events')}}
    where event_type != 'package_shipped'
)

, order_items as (
    select *
    from {{ ref('stg_postgres__order_items')}}
)

, products as (
    select *
    from {{ ref('stg_postgres__products')}}
)

select event_guid
    , user_guid
    , session_guid
    , created_at_utc
    , event_type
    , coalesce(events.product_guid, order_items.product_guid) as product_guid
    , name as product_name
from events
left join  order_items
    on events.order_guid = order_items.order_guid
left join products
    on products.product_guid = events.product_guid
    or products.product_guid = order_items.product_guid