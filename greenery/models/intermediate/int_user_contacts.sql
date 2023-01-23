with users as (
    select *
    from {{ref('stg_postgres__users')}}
),
addresses as (
    select *
    from {{ref('stg_postgres__addresses')}}
)

select
    u.user_guid
    , u.first_name
    , u.last_name
    , u.created_at_utc
    , u.email
    , u.phone_number
    , a.address
    , a.zipcode
    , a.state
    , a.country
from users u
left join addresses a
    on u.address_guid = a.address_guid