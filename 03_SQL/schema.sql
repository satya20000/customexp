-- SQLite 3.25+; populated by pipeline.py, CSV dates are ISO strings.
CREATE TABLE "dim_seller" (
 "seller_id" TEXT,
 "seller_zip_code_prefix" INTEGER,
 "seller_city" TEXT,
 "seller_state" TEXT
);

CREATE TABLE "dim_customer" (
 "customer_id" TEXT,
 "customer_unique_id" TEXT,
 "customer_zip_code_prefix" INTEGER,
 "customer_city" TEXT,
 "customer_state" TEXT
);

CREATE TABLE "dim_product" (
 "product_id" TEXT,
 "product_category_name" TEXT,
 "product_name_lenght" REAL,
 "product_description_lenght" REAL,
 "product_photos_qty" REAL,
 "product_weight_g" REAL,
 "product_length_cm" REAL,
 "product_height_cm" REAL,
 "product_width_cm" REAL
);

CREATE TABLE "fact_payment" (
 "order_id" TEXT,
 "payment_sequential" INTEGER,
 "payment_type" TEXT,
 "payment_installments" INTEGER,
 "payment_value" REAL
);

CREATE TABLE "dim_category" (
 "category" TEXT
);

CREATE TABLE "fact_order" (
 "order_id" TEXT,
 "customer_id" TEXT,
 "order_status" TEXT,
 "order_purchase_timestamp" TEXT,
 "order_approved_at" TEXT,
 "order_delivered_carrier_date" TEXT,
 "order_delivered_customer_date" TEXT,
 "order_estimated_delivery_date" TEXT,
 "gmv" REAL,
 "freight" REAL,
 "items" REAL,
 "payment_value" REAL,
 "customer_unique_id" TEXT,
 "customer_zip_code_prefix" INTEGER,
 "customer_city" TEXT,
 "customer_state" TEXT,
 "review_score" INTEGER,
 "cancelled" INTEGER,
 "delivered" INTEGER,
 "eligible_delivery" INTEGER,
 "delay_days" REAL,
 "late" REAL,
 "processing_days" REAL,
 "shipping_days" REAL,
 "delivery_days" REAL,
 "delay_band" TEXT,
 "purchase_month" TEXT,
 "purchase_date" TEXT
);

CREATE TABLE "bridge_order_seller_category" (
 "order_id" TEXT,
 "seller_id" TEXT,
 "seller_state" TEXT,
 "category" TEXT,
 "item_gmv" REAL,
 "item_freight" REAL
);

CREATE TABLE "seller_performance" (
 "seller_id" TEXT,
 "orders" INTEGER,
 "eligible" INTEGER,
 "late_rate" REAL,
 "review_score" REAL,
 "processing_days" REAL,
 "shipping_days" REAL,
 "segment" TEXT
);

CREATE TABLE "dim_geography" (
 "geolocation_zip_code_prefix" INTEGER,
 "latitude" REAL,
 "longitude" REAL
);

CREATE TABLE "dim_date" (
 "date" TEXT,
 "year" INTEGER,
 "month" TEXT,
 "quarter" INTEGER,
 "month_number" INTEGER
);