-- Enable UUID extension (in case not already enabled)
-- This script assumes schema.sql has already been run.

-- Insert Sample Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
-- Hosts
('a1b2c3d4-e1e1-4b1a-9b0a-1234567890ab', 'James', 'Mwangi', 'james.mwangi@example.com', 'hash_james123', '+254712345678', 'host'),
('b2c3d4e5-f2f2-4c2b-8c1b-234567890abc', 'Amina', 'Otieno', 'amina.otieno@example.com', 'hash_amina456', '+254723456789', 'host'),
('c3d4e5f6-g3g3-4d3c-9d2c-34567890abcd', 'David', 'Koech', 'david.koech@example.com', 'hash_david789', '+254734567890', 'admin');

-- Guests
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('d4e5f6g7-h4h4-4e4d-ad3d-4567890abcde', 'Sarah', 'Kariuki', 'sarah.kariuki@example.com', 'hash_sarah321', '+254745678901', 'guest'),
('e5f6g7h8-i5i5-4f5e-be4e-567890abcdef', 'Linda', 'Wambua', 'linda.wambua@example.com', 'hash_linda654', '+254756789012', 'guest'),
('f6g7h8i9-j6j6-4g6f-cf5f-67890abcdeff', 'Mohammed', 'Ali', 'mohammed.ali@example.com', 'hash_mohammed987', '+254767890123', 'guest');


-- Insert Sample Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
-- James's property
('p1q2r3s4-a1a1-4a1a-8a1a-111111111111', 'a1b2c3d4-e1e1-4b1a-9b0a-1234567890ab', 'Cozy Apartment in Kilimani',
 'Modern 2-bedroom apartment with fast WiFi, kitchen, and secure parking.', 'Nairobi, Kilimani', 5000.00),

-- Amina's property
('q2r3s4t5-b2b2-4b2b-9b2b-222222222222', 'b2c3d4e5-f2f2-4c2b-8c1b-234567890abc', 'Luxury Villa near Lake Naivasha',
 'Spacious 4-bedroom villa with private pool, garden, and lake views.', 'Naivasha, Nakuru County', 15000.00),

-- David's property
('r3s4t5u6-c3c3-4c3c-ac3c-333333333333', 'c3d4e5f6-g3g3-4d3c-9d2c-34567890abcd', 'Mountain Cabin in Nyeri',
 'Rustic cabin near Aberdare National Park. Perfect for nature lovers.', 'Nyeri, Central Kenya', 6500.00);


-- Insert Sample Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
-- Sarah books James's apartment
('b5c6d7e8-c1c1-4c1c-8c1c-101010101010', 'p1q2r3s4-a1a1-4a1a-8a1a-111111111111', 'd4e5f6g7-h4h4-4e4d-ad3d-4567890abcde',
 '2025-09-05', '2025-09-10', 25000.00, 'confirmed'),

-- Linda books Amina's villa
('c6d7e8f9-d2d2-4d2d-9d2d-202020202020', 'q2r3s4t5-b2b2-4b2b-9b2b-222222222222', 'e5f6g7h8-i5i5-4f5e-be4e-567890abcdef',
 '2025-10-15', '2025-10-20', 75000.00, 'confirmed'),

-- Mohammed books David's cabin
('d7e8f9g0-e3e3-4e3e-ae3e-303030303030', 'r3s4t5u6-c3c3-4c3c-ac3c-333333333333', 'f6g7h8i9-j6j6-4g6f-cf5f-67890abcdeff',
 '2025-11-01', '2025-11-05', 26000.00, 'pending'),

-- Sarah books David's cabin again (repeat guest)
('e8f9g0h1-f4f4-4f4f-bf4f-404040404040', 'r3s4t5u6-c3c3-4c3c-ac3c-333333333333', 'd4e5f6g7-h4h4-4e4d-ad3d-4567890abcde',
 '2025-12-20', '2025-12-25', 32500.00, 'confirmed');


-- Insert Sample Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
('pay-001-1111', 'b5c6d7e8-c1c1-4c1c-8c1c-101010101010', 25000.00, 'credit_card'),
('pay-002-2222', 'c6d7e8f9-d2d2-4d2d-9d2d-202020202020', 75000.00, 'paypal'),
('pay-004-4444', 'e8f9g0h1-f4f4-4f4f-bf4f-404040404040', 32500.00, 'stripe');


-- Insert Sample Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
-- Sarah reviews James's apartment
('rev-001-aaaa', 'p1q2r3s4-a1a1-4a1a-8a1a-111111111111', 'd4e5f6g7-h4h4-4e4d-ad3d-4567890abcde', 5,
 'Amazing stay! Very clean, well-furnished, and great location. Will book again.'),

-- Linda reviews Amina's villa
('rev-002-bbbb', 'q2r3s4t5-b2b2-4b2b-9b2b-222222222222', 'e5f6g7h8-i5i5-4f5e-be4e-567890abcdef', 4,
 'Beautiful villa with stunning views. Pool was fantastic. Minor issue with hot water.'),

-- Mohammed reviews David's cabin
('rev-003-cccc', 'r3s4t5u6-c3c3-4c3c-ac3c-333333333333', 'f6g7h8i9-j6j6-4g6f-cf5f-67890abcdeff', 5,
 'Peaceful and close to nature. Host was very helpful and responsive.');


-- Insert Sample Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
-- Sarah messages James
('msg-001-1xxx', 'd4e5f6g7-h4h4-4e4d-ad3d-4567890abcde', 'a1b2c3d4-e1e1-4b1a-9b0a-1234567890ab',
 'Hi James, is late check-in possible? Arriving at 9 PM.'),

-- James replies to Sarah
('msg-002-2xxx', 'a1b2c3d4-e1e1-4b1a-9b0a-1234567890ab', 'd4e5f6g7-h4h4-4e4d-ad3d-4567890abcde',
 'Hi Sarah, yes! I’ll leave the key in the lockbox. Enjoy your trip!'),

-- Linda messages Amina
('msg-003-3xxx', 'e5f6g7h8-i5i5-4f5e-be4e-567890abcdef', 'b2c3d4e5-f2f2-4c2b-8c1b-234567890abc',
 'Hello Amina, do you allow pets? I’d like to bring my small dog.'),
 
-- Amina replies
('msg-004-4xxx', 'b2c3d4e5-f2f2-4c2b-8c1b-234567890abc', 'e5f6g7h8-i5i5-4f5e-be4e-567890abcdef',
 'Hi Linda, yes! Small pets are welcome. Just let me know in advance.');