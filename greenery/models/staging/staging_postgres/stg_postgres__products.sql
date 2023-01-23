with src_products as (
    select * from {{ source('postgres', 'products')}}
)

, rename_recast as (
    SELECT
        PRODUCT_ID as product_guid
        , NAME
        , PRICE
        , INVENTORY
    from src_products
)

select * from rename_recast