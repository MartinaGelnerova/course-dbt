with src_events as (
    select * from {{ source('postgres', 'events')}}
)

, rename_recast as (
    select
        EVENT_ID as event_guid
        , SESSION_ID as session_guid
        , USER_ID as user_guid
        , PAGE_URL
        , CREATED_AT::timestampntz as created_at_utc
        , EVENT_TYPE
        , ORDER_ID as order_guid
        , PRODUCT_ID as product_guid
    from src_events
)

select * from rename_recast