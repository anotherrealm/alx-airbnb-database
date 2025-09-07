-- ==================================================
-- Task 3: Create Indexes for Performance
-- ==================================================

-- Existing indexes (from schema.sql) are good, but let's add more for analytics

-- Booking: frequently queried by date and status
CREATE INDEX IF NOT EXISTS idx_booking_date_status ON Booking(start_date, end_date, status);

-- Review: often filtered by rating
CREATE INDEX IF NOT EXISTS idx_review_rating_created ON Review(rating, created_at);

-- User: search by email and role
-- (already have idx_user_email, but ensure it exists)
-- CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email); -- already in schema

-- Property: search by location and price
CREATE INDEX IF NOT EXISTS idx_property_location_price ON Property(location, pricepernight);

-- Composite index for common join: Booking → Property → User
CREATE INDEX IF NOT EXISTS idx_booking_user_property ON Booking(user_id, property_id);

-- ==================================================
-- Task 3: Analyze Initial Complex Query Performance
-- ==================================================

-- Initial query: Retrieve all bookings with user, property, and payment details
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
ORDER BY b.created_at DESC;
