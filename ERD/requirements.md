# ERD Requirements

This document outlines the entities, attributes, and relationships used in the Airbnb database ER diagram.

## Entities and Attributes

### User
- user_id (PK)
- first_name
- last_name
- email (UNIQUE)
- password_hash
- phone_number
- role (guest/host/admin)
- created_at

### Property
- property_id (PK)
- host_id (FK → User.user_id)
- name
- description
- location
- pricepernight
- created_at
- updated_at

### Booking
- booking_id (PK)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- start_date
- end_date
- total_price
- status (pending/confirmed/canceled)
- created_at

### Payment
- payment_id (PK)
- booking_id (FK → Booking.booking_id)
- amount
- payment_date
- payment_method (credit_card/paypal/stripe)

### Review
- review_id (PK)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- rating (1–5)
- comment
- created_at

### Message
- message_id (PK)
- sender_id (FK → User.user_id)
- recipient_id (FK → User.user_id)
- message_body
- sent_at

## Relationships

| Relationship | Type |
|-------------|------|
| User (host) → Property | One-to-Many |
| User (guest) → Booking | One-to-Many |
| Property → Booking | One-to-Many |
| Booking → Payment | One-to-One or One-to-Many |
| Property → Review | One-to-Many |
| User → Review | One-to-Many |
| User ↔ Message (as sender/recipient) | Many-to-Many (via two FKs) |

## Tools Used
- Draw.io (diagrams.net) for ERD design
- Exported as PNG and embedded in README or submitted as file