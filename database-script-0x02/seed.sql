-- ========================
-- TRUNCATE TABLES (safe for re-seeding)
-- ========================
TRUNCATE TABLE Payment, Booking, Review, Message, Property, "User" RESTART IDENTITY CASCADE;

-- ========================
-- Insert Users
-- ========================
WITH inserted_users AS (
  INSERT INTO "User" (first_name, last_name, email, password_hash, role, created_at)
  VALUES
    ('John', 'Doe', 'john@example.com', 'hashed_password1', 'guest', NOW()),
    ('Jane', 'Doe', 'jane@example.com', 'hashed_password2', 'host', NOW()),
    ('Admin', 'User', 'admin@example.com', 'hashed_password3', 'admin', NOW())
  RETURNING user_id, email
)
SELECT * FROM inserted_users;

-- ========================
-- Insert Properties using Jane as host
-- ========================
WITH jane AS (
  SELECT user_id AS host_id FROM "User" WHERE email='jane@example.com'
),
inserted_properties AS (
  INSERT INTO Property (host_id, name, description, location, pricepernight, created_at)
  SELECT host_id, 'Cozy Apartment', 'A cozy apartment in the city center.', 'Nairobi', 50.00, NOW() FROM jane
  UNION ALL
  SELECT host_id, 'Luxury Condo', 'A luxury condo with ocean view.', 'New York', 150.00, NOW() FROM jane
  RETURNING property_id, name
)
SELECT * FROM inserted_properties;

-- ========================
-- Insert Bookings (John books properties)
-- ========================
WITH john AS (
  SELECT user_id FROM "User" WHERE email='john@example.com'
),
cozy AS (
  SELECT property_id FROM Property WHERE name='Cozy Apartment'
),
luxury AS (
  SELECT property_id FROM Property WHERE name='Luxury Condo'
),
inserted_bookings AS (
  INSERT INTO Booking (user_id, property_id, start_date, end_date, total_price, status, created_at)
  SELECT john.user_id, cozy.property_id, DATE '2025-09-05', DATE '2025-09-10', 250.00, 'confirmed', NOW()
  FROM john, cozy
  UNION ALL
  SELECT john.user_id, luxury.property_id, DATE '2025-09-15', DATE '2025-09-20', 750.00, 'pending', NOW()
  FROM john, luxury
  RETURNING booking_id, property_id
)
SELECT * FROM inserted_bookings;

-- ========================
-- Insert Payments
-- ========================
WITH booking_ids AS (
  SELECT booking_id, total_price FROM Booking
)
INSERT INTO Payment (booking_id, amount, payment_method, payment_date)
SELECT booking_id, total_price, 'credit_card', NOW() FROM booking_ids WHERE total_price=250.00
UNION ALL
SELECT booking_id, total_price, 'paypal', NOW() FROM booking_ids WHERE total_price=750.00;

-- ========================
-- Insert Reviews (John reviews properties)
-- ========================
INSERT INTO Review (property_id, user_id, rating, comment, created_at)
VALUES
  (
    (SELECT property_id FROM Property WHERE name='Cozy Apartment'),
    (SELECT user_id FROM "User" WHERE email='john@example.com'),
    5,
    'Amazing stay! Very cozy and clean.',
    NOW()
  ),
  (
    (SELECT property_id FROM Property WHERE name='Luxury Condo'),
    (SELECT user_id FROM "User" WHERE email='john@example.com'),
    4,
    'Great view, but a bit pricey.',
    NOW()
  )
ON CONFLICT (user_id, property_id) DO NOTHING;

-- ========================
-- Insert Messages
-- ========================
WITH john AS (SELECT user_id AS john_id FROM "User" WHERE email='john@example.com'),
     jane AS (SELECT user_id AS jane_id FROM "User" WHERE email='jane@example.com')
INSERT INTO Message (sender_id, recipient_id, message_body, sent_at)
SELECT john.john_id, jane.jane_id, 'Hi Jane, I am interested in your property. Is it available for my dates?', NOW() FROM john, jane
UNION ALL
SELECT jane.jane_id, john.john_id, 'Hi John, yes, the property is available. Let me know if you want to book!', NOW() FROM john, jane;
