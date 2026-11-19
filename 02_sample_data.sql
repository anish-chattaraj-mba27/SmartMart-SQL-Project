-- Reference data

INSERT INTO categories (category_id, category_name, description) VALUES
    (1, 'Grocery', 'Daily food and household grocery products'),
    (2, 'Beverages', 'Packaged drinks and beverages'),
    (3, 'Personal Care', 'Personal hygiene and care products'),
    (4, 'Home Care', 'Cleaning and household maintenance products'),
    (5, 'Electronics', 'Small consumer electronic accessories');

INSERT INTO suppliers (supplier_id, supplier_name, contact_name, phone, city, rating) VALUES
    (1, 'FreshFields Distributors', 'Rohit Mehra', '9876501001', 'Delhi', 4.6),
    (2, 'BlueWave Beverages', 'Neha Kapoor', '9876501002', 'Noida', 4.3),
    (3, 'CarePlus Wholesale', 'Amit Sinha', '9876501003', 'Ghaziabad', 4.5),
    (4, 'HomeEase Supplies', 'Pooja Verma', '9876501004', 'Greater Noida', 4.1),
    (5, 'TechNest Trading', 'Karan Shah', '9876501005', 'Delhi', 4.4);

INSERT INTO customers (customer_id, first_name, last_name, email, phone, city, registration_date) VALUES
    (1, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '9810000001', 'Delhi', '2026-01-05'),
    (2, 'Diya', 'Verma', 'diya.verma@example.com', '9810000002', 'Noida', '2026-01-12'),
    (3, 'Kabir', 'Singh', 'kabir.singh@example.com', '9810000003', 'Greater Noida', '2026-02-02'),
    (4, 'Anaya', 'Gupta', 'anaya.gupta@example.com', '9810000004', 'Ghaziabad', '2026-02-15'),
    (5, 'Ishaan', 'Mehta', 'ishaan.mehta@example.com', '9810000005', 'Delhi', '2026-03-01'),
    (6, 'Meera', 'Joshi', 'meera.joshi@example.com', '9810000006', 'Noida', '2026-03-08'),
    (7, 'Arjun', 'Rao', 'arjun.rao@example.com', '9810000007', 'Delhi', '2026-03-19'),
    (8, 'Sara', 'Khan', 'sara.khan@example.com', '9810000008', 'Greater Noida', '2026-04-04'),
    (9, 'Vivaan', 'Das', 'vivaan.das@example.com', '9810000009', 'Ghaziabad', '2026-04-12'),
    (10, 'Myra', 'Nair', 'myra.nair@example.com', '9810000010', 'Noida', '2026-05-02'),
    (11, 'Reyansh', 'Paul', 'reyansh.paul@example.com', '9810000011', 'Delhi', '2026-05-15'),
    (12, 'Aadhya', 'Mishra', 'aadhya.mishra@example.com', '9810000012', 'Greater Noida', '2026-06-10');

INSERT INTO employees (employee_id, first_name, last_name, role, hire_date, city) VALUES
    (1, 'Ritika', 'Malhotra', 'Store Manager', '2024-04-10', 'Noida'),
    (2, 'Dev', 'Chauhan', 'Sales Associate', '2024-08-15', 'Noida'),
    (3, 'Simran', 'Bose', 'Sales Associate', '2025-01-20', 'Greater Noida'),
    (4, 'Nikhil', 'Jain', 'Inventory Executive', '2024-11-05', 'Noida'),
    (5, 'Tanya', 'Roy', 'Sales Associate', '2025-03-12', 'Delhi');

INSERT INTO products (product_id, product_name, category_id, supplier_id, unit_price, cost_price, is_active) VALUES
    (101, 'Basmati Rice 5kg', 1, 1, 520, 430, TRUE),
    (102, 'Wheat Flour 5kg', 1, 1, 260, 210, TRUE),
    (103, 'Cooking Oil 1L', 1, 1, 155, 125, TRUE),
    (104, 'Green Tea 100g', 1, 1, 185, 140, TRUE),
    (105, 'Mineral Water 1L', 2, 2, 20, 10, TRUE),
    (106, 'Orange Juice 1L', 2, 2, 110, 78, TRUE),
    (107, 'Shampoo 340ml', 3, 3, 210, 155, TRUE),
    (108, 'Hand Wash 250ml', 3, 3, 95, 62, TRUE),
    (109, 'Laundry Detergent 2kg', 4, 4, 310, 245, TRUE),
    (110, 'Floor Cleaner 1L', 4, 4, 145, 105, TRUE),
    (111, 'USB-C Cable', 5, 5, 299, 180, TRUE),
    (112, 'Wireless Mouse', 5, 5, 650, 420, TRUE);

INSERT INTO inventory (product_id, quantity_on_hand, reorder_level) VALUES
    (101, 35, 12),
    (102, 18, 10),
    (103, 9, 12),
    (104, 22, 8),
    (105, 120, 40),
    (106, 14, 15),
    (107, 11, 10),
    (108, 28, 12),
    (109, 7, 10),
    (110, 16, 8),
    (111, 5, 8),
    (112, 13, 6);

INSERT INTO orders (order_id, customer_id, employee_id, order_date, order_status, payment_method) VALUES
    (1001, 1, 2, '2026-07-01', 'Completed', 'UPI'),
    (1002, 2, 3, '2026-07-02', 'Completed', 'Card'),
    (1003, 3, 2, '2026-07-03', 'Completed', 'UPI'),
    (1004, 4, 5, '2026-07-05', 'Completed', 'Cash'),
    (1005, 5, 2, '2026-07-08', 'Completed', 'Card'),
    (1006, 6, 3, '2026-07-11', 'Completed', 'UPI'),
    (1007, 7, 5, '2026-07-14', 'Completed', 'Net Banking'),
    (1008, 8, 2, '2026-07-17', 'Completed', 'UPI'),
    (1009, 9, 3, '2026-07-19', 'Completed', 'Cash'),
    (1010, 10, 5, '2026-07-22', 'Completed', 'Card'),
    (1011, 11, 2, '2026-07-25', 'Completed', 'UPI'),
    (1012, 12, 3, '2026-07-28', 'Completed', 'Card'),
    (1013, 1, 2, '2026-08-02', 'Completed', 'UPI'),
    (1014, 2, 3, '2026-08-06', 'Completed', 'Card'),
    (1015, 3, 2, '2026-08-09', 'Completed', 'Cash'),
    (1016, 4, 5, '2026-08-12', 'Completed', 'UPI'),
    (1017, 5, 2, '2026-08-16', 'Pending', 'UPI'),
    (1018, 6, 3, '2026-08-19', 'Cancelled', 'Card'),
    (1019, 7, 5, '2026-08-22', 'Completed', 'Net Banking'),
    (1020, 8, 2, '2026-08-25', 'Completed', 'UPI');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_pct) VALUES
    (1001, 101, 1, 520, 0),
    (1001, 105, 6, 20, 0),
    (1001, 108, 2, 95, 5),
    (1002, 102, 2, 260, 0),
    (1002, 106, 2, 110, 5),
    (1002, 109, 1, 310, 0),
    (1003, 103, 3, 155, 0),
    (1003, 104, 1, 185, 0),
    (1003, 105, 4, 20, 0),
    (1004, 107, 2, 210, 10),
    (1004, 108, 2, 95, 0),
    (1004, 110, 1, 145, 0),
    (1005, 101, 1, 520, 5),
    (1005, 102, 1, 260, 0),
    (1005, 111, 1, 299, 0),
    (1006, 105, 10, 20, 0),
    (1006, 106, 3, 110, 0),
    (1006, 108, 1, 95, 0),
    (1007, 112, 1, 650, 0),
    (1007, 111, 2, 299, 5),
    (1008, 109, 2, 310, 0),
    (1008, 110, 2, 145, 0),
    (1008, 103, 1, 155, 0),
    (1009, 101, 1, 520, 0),
    (1009, 104, 2, 185, 0),
    (1009, 106, 1, 110, 0),
    (1010, 107, 1, 210, 0),
    (1010, 108, 3, 95, 0),
    (1010, 105, 5, 20, 0),
    (1011, 102, 2, 260, 0),
    (1011, 103, 2, 155, 5),
    (1011, 109, 1, 310, 0),
    (1012, 112, 1, 650, 10),
    (1012, 111, 1, 299, 0),
    (1012, 110, 1, 145, 0),
    (1013, 101, 1, 520, 0),
    (1013, 105, 8, 20, 0),
    (1013, 106, 2, 110, 0),
    (1014, 102, 1, 260, 0),
    (1014, 107, 1, 210, 0),
    (1014, 108, 2, 95, 0),
    (1015, 103, 2, 155, 0),
    (1015, 104, 2, 185, 5),
    (1015, 109, 1, 310, 0),
    (1016, 110, 2, 145, 0),
    (1016, 105, 6, 20, 0),
    (1016, 108, 1, 95, 0),
    (1017, 112, 1, 650, 0),
    (1017, 111, 1, 299, 0),
    (1018, 106, 2, 110, 0),
    (1018, 105, 4, 20, 0),
    (1019, 101, 1, 520, 0),
    (1019, 102, 2, 260, 0),
    (1019, 103, 1, 155, 0),
    (1020, 107, 2, 210, 0),
    (1020, 109, 1, 310, 0),
    (1020, 110, 1, 145, 0);

-- Reset identity sequences to continue after manually supplied IDs

SELECT setval(pg_get_serial_sequence('customers','customer_id'), (SELECT MAX(customer_id) FROM customers));
SELECT setval(pg_get_serial_sequence('suppliers','supplier_id'), (SELECT MAX(supplier_id) FROM suppliers));
SELECT setval(pg_get_serial_sequence('categories','category_id'), (SELECT MAX(category_id) FROM categories));
SELECT setval(pg_get_serial_sequence('employees','employee_id'), (SELECT MAX(employee_id) FROM employees));
SELECT setval(pg_get_serial_sequence('products','product_id'), (SELECT MAX(product_id) FROM products));
SELECT setval(pg_get_serial_sequence('inventory','inventory_id'), (SELECT MAX(inventory_id) FROM inventory));
SELECT setval(pg_get_serial_sequence('orders','order_id'), (SELECT MAX(order_id) FROM orders));
SELECT setval(pg_get_serial_sequence('order_items','order_item_id'), (SELECT MAX(order_item_id) FROM order_items));
