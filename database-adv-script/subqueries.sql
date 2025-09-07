-- ==================================================
-- Task 1: Subqueries (Correlated and Non-Correlated)
-- ==================================================

-- 1. Non-Correlated Subquery
-- Find all properties where average rating > 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    avg_ratings.avg_rating
FROM Property p
JOIN (
    SELECT 
        property_id, 
        AVG(rating) AS avg_rating
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
) AS avg_ratings ON p.property_id = avg_ratings.property_id
ORDER BY avg_ratings.avg_rating DESC;

-- 2. Correlated Subquery
-- Find users who have made more than 3 bookings
-- Uses a subquery that references outer query (correlated)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM "User" u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.last_name;