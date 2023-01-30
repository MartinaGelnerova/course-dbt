select --product_guid
    product_name
    , count(distinct(iff(event_type = 'page_view', session_guid, null))) as views_ttl
    , count(distinct(iff(event_type = 'add_to_cart', session_guid, null))) as add_to_carts_ttl
    , count(distinct(iff(event_type = 'checkout', session_guid, null))) as checkouts_ttl
    , checkouts_ttl / views_ttl as product_conversion_rate
from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.INT_SESSION_PRODUCT
group by product_name