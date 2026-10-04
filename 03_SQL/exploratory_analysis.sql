-- name: row_count
SELECT COUNT(*) rows FROM fact_order;

-- name: date_coverage
SELECT MIN(order_purchase_timestamp) first_date,MAX(order_purchase_timestamp) last_date FROM fact_order;

