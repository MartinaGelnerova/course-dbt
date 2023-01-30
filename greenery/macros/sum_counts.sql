{%- macro sum_counts (column, value) -%}

    sum(case when {{column}} = '{{value}}' then 1 else 0 end) as {{ value }}s

{%- endmacro -%}