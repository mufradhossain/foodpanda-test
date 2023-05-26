{{
    config(
        materialized='view'
    )
}}

SELECT country_name, SUM(gmv_local) AS total_gmv
FROM orders
GROUP BY country_name;
