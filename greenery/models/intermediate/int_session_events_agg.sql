{{
    config(
        MATERIALIZED = 'table'
    )
}}

with events as (
    select * from {{ref('stg_postgres__events')}}
)

, final as (
    select
    user_guid
    , session_guid
    , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
    , sum(case when event_type = 'checkout' then 1 else 0 end) as checkouts
    , sum(case when event_type = 'package_shipped' then 1 else 0 end) as packages_shipped
    , sum(case when event_type = 'page_view' then 1 else 0 end) as page_views
    , min(created_at_utc) as first_session_event_at_utc
    , max(created_at_utc) as last_session_event_at_utc
    from events
    GROUP BY 1, 2
)

select * from final