-- CTEs, ranks, lag/lead and running totals.

-- name: monthly_change
WITH m AS (SELECT purchase_month month,AVG(late) late_rate,COUNT(*) orders FROM fact_order GROUP BY purchase_month) SELECT *,LAG(late_rate) OVER(ORDER BY month) prior_late_rate,late_rate-LAG(late_rate) OVER(ORDER BY month) change_pp FROM m;

-- name: seller_rank
SELECT *,RANK() OVER(ORDER BY orders*late_rate DESC) late_order_rank FROM seller_performance WHERE eligible>=50;

-- name: delay_deciles
WITH d AS (SELECT NTILE(10) OVER(ORDER BY delay_days) delay_decile,delay_days,review_score FROM fact_order WHERE eligible_delivery=1) SELECT delay_decile,COUNT(*) orders,AVG(delay_days) delay_days,AVG(review_score) review_score FROM d GROUP BY delay_decile;

