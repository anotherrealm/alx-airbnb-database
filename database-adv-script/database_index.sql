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
-- CREATE INDEX idx_user_email ON "User"(email); -- already in schema

-- Property: search by location and price
CREATE INDEX IF NOT EXISTS idx_property_location_price ON Property(location, pricepernight);

-- Composite index for common join: Booking → Property → User
CREATE INDEX IF NOT EXISTS idx_booking_user_property ON Booking(user_id, property_id);