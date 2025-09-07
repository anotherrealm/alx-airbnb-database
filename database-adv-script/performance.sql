-- ==================================================
-- Task 4: Optimized Complex Query (After Optimization)
-- ==================================================

-- Optimization strategies:
-- 1. Use explicit column lists instead of SELECT * (already done).
-- 2. Ensure indexes exist on join and filter columns.
-- 3. Use EXISTS or LIMIT if only a subset is needed.
-- 4. Use CTE for clarity if needed.

-- Add recommended indexes for performance (run once):
-- CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
-- CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
-- CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);

-- Optimized query:
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name AS guest_first,
    u.last_name AS guest_last,
    u.email AS guest_email,
    p.name AS property_name,
    p.location,
    p.pricepernight AS price_per_night,
    pay.amount AS paid_amount,
    pay.payment_method,
    pay.payment_date
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;