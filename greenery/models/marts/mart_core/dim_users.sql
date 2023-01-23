with users as (
    select *
    from {{ref('int_user_contacts')}}
)

, orders as (
    select
        user_guid
        , count(distinct(order_guid)) as count_orders
        , sum(order_total) as total_revenue
    from {{ref('stg_postgres__orders')}}
    group by 1
)

select
    u.user_guid
    , u.first_name
    , u.last_name
    , u.created_at_utc
    , u.email
    , u.phone_number
    , u.address
    , u.zipcode
    , u.state
    , u.country
    , count_orders
    , total_revenue
from users u
left join orders o
    on u.user_guid = o.user_guid