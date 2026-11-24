# SmartMart – Retail Sales, Inventory and Supplier Management System

## Project Overview
SmartMart is a PostgreSQL-based retail management database project designed to analyse sales, manage inventory, track suppliers, and generate useful business insights.

## Project Objectives
- Design a relational database for retail operations.
- Manage customers, suppliers, products, employees, inventory, and orders.
- Perform sales and customer analysis using SQL.
- Identify inventory trends and support business decisions.
- Maintain data accuracy using constraints and transactions.

## Database Structure
The database consists of eight tables:
1. Customers
2. Suppliers
3. Categories
4. Employees
5. Products
6. Inventory
7. Orders
8. Order Items

## Repository Contents
- `01_schema.sql` – Creates database tables, constraints, and indexes.
- `02_sample_data.sql` – Inserts sample data.
- `03_analysis_queries.sql` – Contains SQL analysis queries.
- `04_transactions.sql` – Demonstrates transaction management.
- CSV files – Sample datasets.
- ERD image – Database relationship diagram.
- Screenshots – Project execution evidence.
- Project report and presentation.

## How to Run the Project
1. Open PostgreSQL using pgAdmin or another SQL client.
2. Create or select a database.
3. Execute the SQL files in this order:
   - `01_schema.sql`
   - `02_sample_data.sql`
   - `03_analysis_queries.sql`
   - `04_transactions.sql`
4. Review the query outputs and analysis.

**Note:** The schema script recreates the project tables. Run it only in a suitable project database, not in a database containing important existing data.

## SQL Concepts Used
- CREATE TABLE and INSERT
- Primary and Foreign Keys
- JOIN operations
- Aggregate functions
- GROUP BY and HAVING
- Subqueries and CTEs
- Window functions
- Data quality checks
- Transactions, COMMIT, ROLLBACK, and SAVEPOINT

## Business Applications
The project demonstrates how SQL can help a retail business:
- Monitor sales performance.
- Identify valuable customers.
- Track inventory levels.
- Analyse supplier relationships.
- Generate business performance indicators.

## Project Information
**Course:** PMDE30605  
**Institution:** IILM University, Greater Noida  
**Project:** SmartMart – Retail Sales, Inventory and Supplier Management System Using PostgreSQL

## Team Members
- Anish Chattaraj
- Aurobinda Banerjee
- Harsh Kumar Singh
- Harsh Raj
- Shloka Jain

*This academic project uses sample data for demonstration and analysis purposes.*
