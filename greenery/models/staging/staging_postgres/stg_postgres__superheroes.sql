with src_superheroes as (
    select *
    from {{ source('postgres', 'superheroes')}}
)

, rename_recast as (
    SELECT
        ID as superhero_guid
        , NAME
        , GENDER
        , EYE_COLOR
        , RACE
        , HAIR_COLOR
        , NULLIF(height, -99) as height
        , PUBLISHER
        , SKIN_COLOR
        , ALIGNMENT
        , NULLIF(weight, -99) as weight
        , CREATED_AT::timestampntz as created_at_utc
        , UPDATED_AT::timestampntz as updated_at_utc
        , {{ lbs_to_kgs('weight') }} AS weight_kg
    from src_superheroes
)

select * from rename_recast