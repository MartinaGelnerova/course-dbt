with src_users as (
    select * from {{ source('postgres', 'users')}}
)

, rename_recast as (
    SELECT
        USER_ID as user_guid
        , FIRST_NAME
        , LAST_NAME
        , EMAIL
        , PHONE_NUMBER
        , CREATED_AT::timestampntz as created_at_utc
        , UPDATED_AT::timestampntz as updated_at_utc
        , ADDRESS_ID as address_guid
    from src_users
)

select * from rename_recast