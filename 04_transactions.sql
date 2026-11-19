-- Transaction management demonstration. Run each section separately.
-- 1. ROLLBACK: the temporary stock reduction will be undone.
BEGIN;
UPDATE inventory
SET quantity_on_hand = quantity_on_hand - 1
WHERE product_id = 101;
SELECT product_id, quantity_on_hand FROM inventory WHERE product_id = 101;
ROLLBACK;
SELECT product_id, quantity_on_hand FROM inventory WHERE product_id = 101;

-- 2. SAVEPOINT and COMMIT: controlled update. Re-run seed data to restore baseline.
BEGIN;
UPDATE inventory SET quantity_on_hand = quantity_on_hand + 1 WHERE product_id = 102;
SAVEPOINT stock_adjustment;
UPDATE inventory SET last_updated = CURRENT_TIMESTAMP WHERE product_id = 102;
COMMIT;
