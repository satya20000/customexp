-- Source transformations are reproducible in 04_Python. These SQL controls execute on the derived model.
-- name: duplicate_keys
SELECT order_id,COUNT(*) copies FROM fact_order GROUP BY order_id HAVING COUNT(*)>1;

-- name: null_keys
SELECT COUNT(*) invalid_rows FROM fact_order WHERE order_id IS NULL;

