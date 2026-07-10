-- ============================================
-- Validation 1: Verify total number of records
-- Objective: Ensure all cleaned records were imported
-- Expected Result: 180,519 rows
-- ============================================
SELECT COUNT(*) AS Total_Rows
FROM datacosupplychain_clean;

-- ============================================
-- Validation 2: Verify total number of columns
-- Objective: Ensure all columns were imported
-- Expected Result: 48 columns
-- ============================================
DESCRIBE datacosupplychain_clean;

-- ============================================
-- Validation 3: Check for missing values
-- Objective: Ensure there are no missing values in the dataset
-- Expected Result: Mostly 0
-- ============================================
SELECT
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Missing_Sales,
SUM(CASE WHEN `Benefit per order` IS NULL THEN 1 ELSE 0 END) AS Missing_Profit,
SUM(CASE WHEN Market IS NULL THEN 1 ELSE 0 END) AS Missing_Market,
SUM(CASE WHEN `Delivery Status` IS NULL THEN 1 ELSE 0 END) AS Missing_Delivery_Status
FROM datacosupplychain_clean;

-- ============================================
-- Validation 4: Distinct Values
-- Objective: Ensure there are correct markets
-- Expected Result: Africa,Europe,LATAM,Pacific Asia,USCA
-- ============================================
SELECT DISTINCT Market
FROM datacosupplychain_clean;


-- ============================================
-- Validation 5: Deliver status
-- Objective: Ensuring there are appropriate delivery statuses
-- Expected Result: Late delivery,Advance shipping,Shipping on time,Shipping canceled
-- ============================================
SELECT DISTINCT `Delivery Status`
FROM datacosupplychain_clean;

-- ============================================
-- Validation 6: Order Status
-- Objective: Verify that all expected statuses are present.
-- Expected Result: 9 order statuses
-- ============================================
SELECT DISTINCT `Order Status`
FROM datacosupplychain_clean;

-- ============================================
-- Validation 7: order date range values
-- Objective: Comparing this with the dates observed in Python.
-- Expected Result: 2015-01-01 00:00:00,2018-01-31 23:38:00
-- ============================================
SELECT
MIN(`order date (DateOrders)`) AS First_Order,
MAX(`order date (DateOrders)`) AS Last_Order
FROM datacosupplychain_clean;

-- ============================================
-- Validation 8: shipping date range values
-- Objective: Comparing this with the dates observed in Python.
-- Expected Result: 2015-01-03 00:00:00,2018-02-06 22:14:00
-- ============================================
SELECT
MIN(`shipping date (DateOrders)`) AS First_Order,
MAX(`shipping date (DateOrders)`) AS Last_Order
FROM datacosupplychain_clean;