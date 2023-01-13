with src_promos as (
    select *
    from {{ source('postgres', 'promos')}}
)

, rename_recast as (
    SELECT
        PROMO_ID as promo_guid
        , DISCOUNT
        , STATUS::boolean as status
    from src_promos
)

select * from rename_recast