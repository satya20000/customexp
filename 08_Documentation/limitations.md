# Limitations

- Calendar dates define on-time delivery because estimated dates are day-level promises. Same-day delivery counts as on-time.
- Latest review response, then creation time and review ID, determines one selected review per order. Raw review history remains unchanged.
- Processing and shipping averages exclude negative timestamp intervals independently; their samples may differ.
- Multi-seller and multi-category orders count once at order grain. Seller/category comparisons use distinct order membership and cannot uniquely assign blame.
- No carrier identifier exists. Shipping bottlenecks are measured by routes and elapsed time, not named-carrier performance.
- Review associations do not prove operational causation; confounding by category, geography, season and seller mix remains.