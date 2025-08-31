# Airbnb Database Seed Script

This directory contains SQL scripts to **populate the Airbnb database with sample data** for testing and demonstration.

## Files

- `seed.sql`: SQL `INSERT` statements to add realistic sample data into all tables.
- This `README.md`.

## Tables Seeded

- `User`: 6 users (2 hosts, 3 guests, 1 admin)
- `Property`: 3 rental listings in different locations
- `Booking`: 4 bookings (including repeat guest)
- `Payment`: 3 payments (different methods)
- `Review`: 3 reviews (with ratings and comments)
- `Message`: 4 message exchanges (guest-host conversations)

## Data Characteristics

- Realistic names, emails, and Kenyan phone numbers (formatted with +254)
- Geographically diverse property locations (Nairobi, Naivasha, Nyeri)
- Varied booking statuses (`confirmed`, `pending`)
- Multiple payment methods (`credit_card`, `paypal`, `stripe`)
- Natural language in reviews and messages
- Referential integrity maintained (no orphaned records)

## Usage

Run this script **after** `schema.sql` has been executed:

```bash
psql -U your_user -d your_database -f seed.sql