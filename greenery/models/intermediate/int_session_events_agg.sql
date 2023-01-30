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
    , {{ sum_counts ("event_type", 'add_to_cart') }}
    , {{ sum_counts ("event_type", 'checkout') }}
    , {{ sum_counts ("event_type", 'package_shipped') }}
    , {{ sum_counts ("event_type", 'page_view') }}
    , min(created_at_utc) as first_session_event_at_utc
    , max(created_at_utc) as last_session_event_at_utc
    from events
    GROUP BY 1, 2
)

select * from final