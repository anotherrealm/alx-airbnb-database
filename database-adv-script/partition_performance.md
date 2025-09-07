# Partitioning Performance Report

## Goal
Improve query speed on large `Booking` tables using range partitioning.

## Test Query
```sql
SELECT * FROM Booking_Partitioned WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';