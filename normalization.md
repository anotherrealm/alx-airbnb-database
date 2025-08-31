# Database Normalization (3NF)

## Objective
To ensure the Airbnb database design is efficient, consistent, and free from redundancy by applying normalization rules up to the **Third Normal Form (3NF)**.

---

## Step 1: First Normal Form (1NF)
- ✅ Each table has a primary key.
- ✅ No repeating groups or arrays.
- ✅ All attributes are atomic (e.g., `first_name`, `last_name`, `email` instead of full name).
  
**Example**:  
- `User` table has atomic attributes (`id`, `first_name`, `last_name`, `email`, `phone`).  
- `Property` table has attributes (`id`, `title`, `description`, `price_per_night`, `host_id`).  

---

## Step 2: Second Normal Form (2NF)
- ✅ All non-key attributes are fully dependent on the **entire primary key**.
- ✅ No partial dependencies.

**Example**:  
- In the `Booking` table (`id`, `user_id`, `property_id`, `start_date`, `end_date`, `total_price`), every non-key attribute depends on the full primary key (`id`), not just part of it.

---

## Step 3: Third Normal Form (3NF)
- ✅ No **transitive dependencies** (non-key attributes must not depend on other non-key attributes).  
- ✅ Each attribute depends only on the primary key.

**Adjustments Considered**:
- `Location` was already stored as its own entity (`id`, `city`, `country`) instead of keeping these in `Property`, preventing redundancy.  
- No further changes were necessary because all relationships are clean, and data is stored in the right entities.

---

## Conclusion
The database schema is already in **Third Normal Form (3NF)**.  
- Data is atomic and well-structured.  
- No redundancies or transitive dependencies.  
- Ensures scalability, integrity, and efficient querying for the Airbnb system.

