-- Grain-safe SQLite business queries. Monetary values are source currencies.

-- name: portfolio_kpis
SELECT COUNT(*) orders,SUM(delivered) delivered,SUM(cancelled) cancelled,AVG(cancelled*1.0) cancellation_rate,AVG(late) late_rate,1-AVG(late) on_time_rate,AVG(delivery_days) delivery_days,AVG(processing_days) processing_days,AVG(shipping_days) shipping_days,AVG(review_score) review_score,AVG(freight) freight,AVG(gmv) item_aov FROM fact_order;

-- name: status_mix
SELECT order_status,COUNT(*) orders FROM fact_order GROUP BY order_status;

-- name: delivery_trend
SELECT purchase_month,COUNT(*) orders,SUM(eligible_delivery) eligible,AVG(late) late_rate,AVG(delivery_days) delivery_days,AVG(review_score) review_score,AVG(cancelled*1.0) cancelled_rate FROM fact_order GROUP BY purchase_month ORDER BY purchase_month;

-- name: delay_review
SELECT delay_band,COUNT(*) orders,COUNT(review_score) reviewed,AVG(review_score) review_score,AVG(CASE WHEN review_score IS NOT NULL THEN CASE WHEN review_score=1 THEN 1.0 ELSE 0 END END) one_star_rate FROM fact_order GROUP BY delay_band;

-- name: late_vs_ontime
SELECT late,COUNT(*) eligible,COUNT(review_score) reviewed,AVG(review_score) review_score,AVG(CASE WHEN review_score IS NOT NULL THEN CASE WHEN review_score=1 THEN 1.0 ELSE 0 END END) one_star_rate FROM fact_order WHERE eligible_delivery=1 GROUP BY late;

-- name: review_distribution
SELECT review_score,COUNT(*) orders FROM fact_order WHERE review_score IS NOT NULL GROUP BY review_score;

-- name: state_delivery
SELECT customer_state,COUNT(*) orders,AVG(delivery_days) delivery_days,AVG(late) late_rate,AVG(review_score) review_score FROM fact_order GROUP BY customer_state;

-- name: seller_priority
SELECT * FROM seller_performance WHERE eligible>=50 AND late_rate>(SELECT AVG(late) FROM fact_order) ORDER BY orders*late_rate DESC;

-- name: seller_low_reviews
SELECT * FROM seller_performance WHERE eligible>=50 ORDER BY review_score ASC;

-- name: category_experience
WITH distinct_orders AS (SELECT DISTINCT b.order_id,category segment FROM bridge_order_seller_category b JOIN fact_order o USING(order_id)) SELECT d.segment,COUNT(*) orders,SUM(o.eligible_delivery) eligible,AVG(o.late) late_rate,AVG(o.review_score) review_score,AVG(o.processing_days) processing_days,AVG(o.shipping_days) shipping_days FROM distinct_orders d JOIN fact_order o USING(order_id) GROUP BY d.segment HAVING SUM(o.eligible_delivery)>=50 ORDER BY late_rate DESC;

-- name: routes
WITH distinct_orders AS (SELECT DISTINCT b.order_id,seller_state || ' to ' || customer_state segment FROM bridge_order_seller_category b JOIN fact_order o USING(order_id)) SELECT d.segment,COUNT(*) orders,SUM(o.eligible_delivery) eligible,AVG(o.late) late_rate,AVG(o.review_score) review_score,AVG(o.processing_days) processing_days,AVG(o.shipping_days) shipping_days FROM distinct_orders d JOIN fact_order o USING(order_id) GROUP BY d.segment HAVING SUM(o.eligible_delivery)>=50 ORDER BY late_rate DESC;

-- name: freight_review
SELECT CASE WHEN freight<10 THEN '<10' WHEN freight<20 THEN '10-20' WHEN freight<40 THEN '20-40' ELSE '40+' END freight_band,COUNT(*) orders,AVG(review_score) review_score,AVG(late) late_rate FROM fact_order WHERE freight IS NOT NULL GROUP BY 1;

-- name: stage_times
SELECT 'Processing' stage,COUNT(processing_days) observations,AVG(processing_days) days FROM fact_order UNION ALL SELECT 'Shipping',COUNT(shipping_days),AVG(shipping_days) FROM fact_order UNION ALL SELECT 'Total delivery',COUNT(delivery_days),AVG(delivery_days) FROM fact_order;

-- name: same_sample_stage_times
SELECT COUNT(*) orders,AVG(processing_days) processing_days,AVG(shipping_days) shipping_days,AVG(review_score) review_score FROM fact_order WHERE processing_days IS NOT NULL AND shipping_days IS NOT NULL;

-- name: estimate_accuracy
SELECT COUNT(*) eligible,AVG(delay_days) signed_error_days,AVG(ABS(delay_days)) absolute_error_days,AVG(CASE WHEN delay_days>0 THEN delay_days END) late_orders_delay_days FROM fact_order WHERE eligible_delivery=1;

-- name: seller_segments
SELECT segment,COUNT(*) sellers,SUM(orders) order_seller_pairs,AVG(late_rate) unweighted_seller_late_rate FROM seller_performance GROUP BY segment;

-- name: cancellation_states
SELECT customer_state,COUNT(*) orders,SUM(cancelled) cancelled,AVG(cancelled*1.0) cancellation_rate FROM fact_order GROUP BY customer_state;

-- name: review_missingness
SELECT order_status,COUNT(*) orders,COUNT(review_score) reviewed,COUNT(review_score)*1.0/COUNT(*) review_coverage FROM fact_order GROUP BY order_status;

