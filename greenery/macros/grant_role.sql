{% macro grant(role) %}

    {% set sql %}
        GRANT SELECT ON table {{ this }} TO ROLE {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}