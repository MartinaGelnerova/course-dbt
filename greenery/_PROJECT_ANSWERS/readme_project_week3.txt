PART 1: CREATE NEW MODELS TO ANSWER THE FIRST TWO QUESTIONS
I have created intermediate model int_session_product, which allows to quantify product/event funnel as well as answer the questions.

WHAT IS OUR OVERALL CONVERSION RATE?
    0.624567

Query:
    select count(distinct (iff(event_type = 'checkout', session_guid, null))) as checkouts_overall
        , count(distinct session_guid) as sessions_overall
        , checkouts_overall / sessions_overall as overall_conversion_rate
    from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.INT_SESSION_PRODUCT

WHAT IS OUR CONVERSION RATE BY PRODUCT?
    PRODUCT_NAME	    VIEWS_TTL	ADD_TO_CARTS_TTL	CHECKOUTS_TTL	PRODUCT_CONVERSION_RATE
    Alocasia Polly	    51	        27	                21	            0.411765
    Aloe Vera	        65	        36	                32	            0.492308
    Angel Wings Begonia	61	        32	                24	            0.393443
    Arrow Head	        63	        39	                35	            0.555556
    Bamboo	            67	        42	                36	            0.537313
    Bird of Paradise	60	        33	                27	            0.45
    Birds Nest Fern	    78	        40	                33	            0.423077
    Boston Fern	        63	        34	                26	            0.412698
    Cactus	            55	        32	                30	            0.545455
    Calathea Makoyana	53	        32	                27	            0.509434
    Devil's Ivy	        45	        24	                22	            0.488889
    Dragon Tree	        62	        34	                29	            0.467742
    Ficus	            68	        35	                29	            0.426471
    Fiddle Leaf Fig	    56	        30	                28	            0.5
    Jade Plant	        46	        24	                22	            0.478261
    Majesty Palm	    67	        38	                33	            0.492537
    Money Tree	        56	        26	                26	            0.464286
    Monstera	        49	        26	                25	            0.510204
    Orchid	            75	        37	                34	            0.453333
    Peace Lily	        66	        35	                27	            0.409091
    Philodendron	    62	        32	                30	            0.483871
    Pilea Peperomioides	59	        31	                28	            0.474576
    Pink Anthurium	    74	        37	                31	            0.418919
    Ponytail Palm	    70	        30	                28	            0.4
    Pothos	            61	        24	                21	            0.344262
    Rubber Plant	    54	        32	                28	            0.518519
    Snake Plant	        73	        34	                29	            0.39726
    Spider Plant	    59	        30	                28	            0.474576
    String of pearls	64	        44	                39	            0.609375
    ZZ Plant	        63	        35	                34	            0.539683

Query:
    select 
        product_name
        , count(distinct(iff(event_type = 'page_view', session_guid, null))) as views_ttl
        , count(distinct(iff(event_type = 'add_to_cart', session_guid, null))) as add_to_carts_ttl
        , count(distinct(iff(event_type = 'checkout', session_guid, null))) as checkouts_ttl
        , checkouts_ttl / views_ttl as product_conversion_rate
    from DEV_DB.DBT_MARTINAGELNEROVAAPIFYCOM.INT_SESSION_PRODUCT
    group by product_name
    order by product_name asc

PART 2: CREATE A MACRO TO SIMPLIFY PART OF A MODEL(S)
I have created macro sum_counts.sql which returns sum of counts for input column name and value. I used this in greenery/models/intermediate/int_session_events_agg.sql

PART 3: ADD A POST HOOK TO YOUR PROJECT TO APPLY GRANTS TO THE ROLE “REPORTING”.
Done with grant_role.sql macro.

PART 4: INSTALL A PACKAGE
I already had dbt_utils installed, so I installed dbt_expectations as a new package.
I used dbt_expectations_expect_column_pair_values_A_to_be_greater_than_B in my new fct table fct_product_sessions where I am checking that ttl number of views of the product page is greater then ttl number of add_to_cart and this is greater than ttl number of checkouts.

PART 5: WHICH ORDERS CHANGED FROM WEEK 2 TO WEEK 3?
These 3 order_guids have changed (status from preparing to shipped):
    29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6
    c0873253-7827-4831-aa92-19c38372e58d
    e2729b7d-e313-4a6f-9444-f7f65ae8db9a