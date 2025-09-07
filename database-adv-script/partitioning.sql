-- ==================================================
-- Task 5: Partition Booking Table by start_date
-- ==================================================

-- Step 1: Drop old partitioned table if re-running
-- DROP TABLE IF EXISTS Booking_Partitioned CASCADE;

-- Step 2: Recreate as partitioned table
CREATE TABLE Booking_Partitioned (
    booking_id UUID DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_date_range CHECK (end_date > start_date)
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions for each year
CREATE TABLE Booking_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE Booking_2026 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

CREATE TABLE Booking_2027 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2027-01-01') TO ('2028-01-01');

-- Optional: Add index on user_id and property_id for faster lookups
CREATE INDEX IF NOT EXISTS idx_booking_partitioned_user_id ON Booking_Partitioned(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_partitioned_property_id ON Booking_Partitioned(property_id);

-- Insert sample data
INSERT INTO Booking_Partitioned (property_id, user_id, start_date, end_date, total_price, status)
VALUES 
    ((SELECT property_id FROM Property LIMIT 1), 
     (SELECT user_id FROM "User" WHERE role = 'guest' LIMIT 1), 
     '2025-09-05', '2025-09-10', 250.00, 'confirmed');

-- Query: Fast lookup within date range
EXPLAIN ANALYZE
SELECT * FROM Booking_Partitioned
WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';
