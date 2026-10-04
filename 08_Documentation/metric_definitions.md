# Metric definitions and exclusions

- Calendar dates define on-time delivery because estimated dates are day-level promises. Same-day delivery counts as on-time.
- Latest review response, then creation time and review ID, determines one selected review per order. Raw review history remains unchanged.
- Processing and shipping averages exclude negative timestamp intervals independently; their samples may differ.
- Multi-seller and multi-category orders count once at order grain. Seller/category comparisons use distinct order membership and cannot uniquely assign blame.
- No carrier identifier exists. Shipping bottlenecks are measured by routes and elapsed time, not named-carrier performance.
- Review associations do not prove operational causation; confounding by category, geography, season and seller mix remains.

Eligibility = delivered status and nonmissing actual and estimated dates. Late = actual calendar date > estimated calendar date. Unknown eligibility is excluded from late-rate denominators. Processing = carrier handoff - approval, shipping = delivery - carrier handoff, total = delivery - purchase, using elapsed fractional days. Negative intervals become NULL independently. One/five-star rates use reviewed orders only. Cancellation = canceled status / all orders. Freight and item AOV are mean summed item freight and mean item-price total across orders with item totals. Average delay days refers to late eligible deliveries; signed and absolute promise errors are separately exported. High-volume seller threshold = median order count; reliable = late rate <= portfolio baseline, with at least 20 eligible deliveries; priority queue requires 50 eligible and above-baseline late rate.
