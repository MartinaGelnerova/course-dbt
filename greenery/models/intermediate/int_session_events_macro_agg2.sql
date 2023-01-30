{{
    config(
        MATERIALIZED = 'table'
    )
}}

select
    user_guid
    , session_guid
    {{ make_event_types_with_counts() }}
from {{ ref('stg_postgres__events')}}
    GROUP BY 1, 2