{{
    config(
        materialized='view'
    )
}}

SELECT o.country_name, v.vendor_name, SUM(o.gmv_local) AS total_gmv
FROM orders o
JOIN vendors v ON o.vendor_id = v.id
WHERE v.is_active = TRUE
GROUP BY o.country_name, v.vendor_name
HAVING SUM(o.gmv_local) = (
    SELECT MAX(subquery.total_gmv)
    FROM (
        SELECT o.country_name, v.vendor_name, SUM(o.gmv_local) AS total_gmv
        FROM orders o
        JOIN vendors v ON o.vendor_id = v.id
        WHERE v.is_active = TRUE
        GROUP BY o.country_name, v.vendor_name
    ) AS subquery
    WHERE subquery.country_name = o.country_name
)
ORDER BY o.country_name;
