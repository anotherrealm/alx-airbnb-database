# Index Performance Analysis

## Objective
Measure query performance before and after adding indexes.

## Method
Use `EXPLAIN ANALYZE` to compare execution plans.

## Example Query
```sql
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date >= '2025-09-01' AND status = 'confirmed';