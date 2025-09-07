-- ==================================================
-- Task 0: Complex Queries with Joins
-- ==================================================

-- 1. INNER JOIN: All bookings with user details
-- Retrieves booking info + guest name and email
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM Booking b
INNER JOIN "User" u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- 2. LEFT JOIN: All properties and their reviews (include properties with no reviews)
-- Shows properties even if they have no ratings
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COALESCE(r.rating, 0) AS rating,
    COALESCE(r.comment, 'No review yet') AS comment,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
LEFT JOIN "User" u ON p.host_id = u.user_id
ORDER BY p.name;

-- 3. FULL OUTER JOIN: All users and all bookings
-- Includes users with no bookings AND bookings with no valid user (e.g., deleted users)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM "User" u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id
ORDER BY u.last_name, b.start_date;