-- ...existing code...

EXPLAIN ANALYZE
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
WHERE b.status = 'confirmed' AND p.location = 'Nairobi'
ORDER BY b.created_at DESC;