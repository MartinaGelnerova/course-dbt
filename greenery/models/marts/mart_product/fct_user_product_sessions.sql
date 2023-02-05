with "session_events" as (
    select *
    from {{ref('int_session_events_agg')}}
)

, "session_product" as (
    select *
    from {{ref('int_session_product')}}
)

 select
    se.user_guid
    , se.session_guid
    , add_to_carts
    , checkouts
    , package_shippeds
    , page_views
    , first_session_event_at_utc
    , last_session_event_at_utc
    , product_guid
    , product_name
    from "session_events" se
    left join "session_product" sp
        on se.session_guid = sp.session_guid