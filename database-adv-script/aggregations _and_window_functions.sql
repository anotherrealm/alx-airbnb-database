-- ==================================================
-- Task 2: Aggregations and Window Functions
-- ==================================================

-- 1. Total number of bookings per user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM "User" u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC;

-- 2. Rank properties by number of bookings using RANK()
-- Handle ties properly (same rank if same count)
SELECT 
    p.property_id,
    p.name,
    p.location,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
JOIN "User" host ON p.host_id = host.user_id
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, host.first_name, host.last_name
ORDER BY total_bookings DESC;