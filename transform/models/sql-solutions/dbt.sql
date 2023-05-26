{{
    config(
        materialized='view'
    )
}}
SELECT MAX(total_gmv) AS max_gmv
FROM {{ref('q1')}};
