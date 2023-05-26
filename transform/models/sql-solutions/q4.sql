{{
    config(
        materialized='view'
    )
}}


WITH ranked_vendors AS (
  SELECT
    v.country_name,
    EXTRACT(YEAR FROM o.date_local) AS year,
    v.vendor_name,
    SUM(o.gmv_local) AS total_gmv,
    ROW_NUMBER() OVER (PARTITION BY v.country_name, EXTRACT(YEAR FROM o.date_local) ORDER BY SUM(o.gmv_local) DESC) AS rank
  FROM
    orders o
    JOIN vendors v ON o.vendor_id = v.id
  GROUP BY
    v.country_name,
    EXTRACT(YEAR FROM o.date_local),
    v.vendor_name,
    o.date_local
)
SELECT
  year,
  country_name,
  vendor_name,
  total_gmv
FROM
  ranked_vendors
WHERE
  rank <= 2
ORDER BY
  year,
  country_name,
  rank
