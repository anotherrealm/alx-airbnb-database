# Airbnb Database Schema

This directory contains the PostgreSQL DDL script to set up the database schema for the Airbnb-clone application.

## Files

- `schema.sql`: SQL script to create all tables, constraints, indexes, and relationships.
- This `README.md`.

## Entities Included

- `User`: Stores guest, host, and admin accounts.
- `Property`: Rental listings created by hosts.
- `Booking`: Reservations made by guests.
- `Payment`: Payment records linked to bookings.
- `Review`: Guest reviews and ratings for properties.
- `Message`: Messaging system between users.

## Features

- Uses **UUIDs** for globally unique identifiers.
- Enforces **referential integrity** via foreign key constraints.
- Implements **check constraints** for data validity (e.g., rating 1–5, valid status).
- Includes **indexes** on frequently queried fields for performance.
- Compatible with **PostgreSQL 12+**.

## Setup Instructions

1. Ensure PostgreSQL is installed and running.
2. Enable the `uuid-ossp` extension:
   ```sql
   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";