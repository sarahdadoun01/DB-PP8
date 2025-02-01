# Manlika Order Management System

This project contains the SQL scripts to manage orders for a business, using an Oracle database. The system allows for creating new orders, verifying stock availability, and managing order processing.

## Features

- **Create New Order**: A procedure to create new orders by inserting them into the `orders` table. It automatically generates a new order ID using a sequence (`manlika_sequence`).
  
- **Quantity on Hand (QOH) Verification**: The system verifies whether the quantity on hand (QOH) is sufficient to fulfill the order.

## Database Structure

The package body contains procedures that interact with the following tables:

- **Orders Table**: Stores the details of the orders including order ID, payment method, customer ID, and operating system ID.

- **Sequence**: `manlika_sequence` is used to generate unique order IDs.

## Installation and Setup

1. **Create the Package**: 
   Execute the provided SQL script in your Oracle database to create the necessary package and procedures.

   ```sql
   @path/to/sarah_pp8.sql

## Database Requirements: 

### Ensure that the following tables and sequence exist in the database:

+ orders table
+ manlika_sequence sequence

### Calling the Procedures: After setting up the database, you can call the procedures to create new orders or verify the availability of stock.
Example Usage

   ```sql
   BEGIN
       -- Create a new order with a customer ID, payment method, and operating system ID
       manlika.create_new_order(101, 'Credit Card', 1);
   END;
