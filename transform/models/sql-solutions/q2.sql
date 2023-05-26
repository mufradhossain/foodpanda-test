{{
    config(
        materialized='view'
    )
}}

SELECT v.vendor_name, COUNT(DISTINCT o.customer_id) AS customer_count, SUM(o.gmv_local) AS total_gmv
FROM orders o
JOIN vendors v ON o.vendor_id = v.id
WHERE v.country_name = 'Taiwan'
GROUP BY v.vendor_name
ORDER BY customer_count DESC;
