-- ===============================================
-- Business Question 1- Overall Business Performance
-- Objective: It combines multiple KPIs into a single query, which is more efficient than writing five separate queries.
-- Expected Business Value:Total Sales: $36,784,735.01,Total Profit: $3,966,902.97,Total Orders: 65,752,Unique Customers: 20,652,Average Discount: 10.17%,Late Delivery Rate: 54.83%
-- ===============================================
SELECT
    COUNT(DISTINCT `Order Id`) AS Total_Orders,
    COUNT(DISTINCT `Customer Id`) AS Unique_Customers,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(`Benefit per order`),2) AS Total_Profit,
    ROUND(AVG(`Order Item Discount Rate`) * 100,2) AS Avg_Discount_Percentage
FROM datacosupplychain_clean;

-- Observation:
-- Same as Expected Results


-- ===============================================
-- Business Question 2- Market-wise Sales
-- Objective: to analyze which market generated the highest revenue
-- ===============================================
SELECT
    Market,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM datacosupplychain_clean
GROUP BY Market
ORDER BY Total_Sales DESC;
-- Observation:
-- Europe market generated the highest revenue


-- ===============================================
-- Business Question 3- Department-wise Profit
-- Objective: to analyze which department generated the highest profit
-- ===============================================
SELECT
    `Department Name`,
    ROUND(SUM(`Benefit per order`),2) AS Total_Profit
FROM datacosupplychain_clean
GROUP BY `Department Name`
ORDER BY Total_Profit DESC;
-- Observation:
-- fan shop generated the highest profit while book shop generated the lowest profit


-- ===============================================
-- Business Question 4- State-wise Sales
-- Objective: to analyze which state generated the highest sales
-- ===============================================
SELECT
    `Order State`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM datacosupplychain_clean
GROUP BY `Order State`
ORDER BY Total_Sales DESC
LIMIT 10;
-- Observation:
-- Inglaterra has highest sales while Queensland generated lowest sales


-- ===============================================
-- Business Question 5- Product-wise Revenue
-- Objective: to analyze which product contributed to most of the revenue
-- ===============================================
SELECT
    `Product Name`,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM datacosupplychain_clean
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;
-- Observation:
-- Field & Stream sportsman 16 Gun fire safe generated the highest revenue in products and Dell laptop generated the lowest revenue


-- ===============================================
-- Business Question 6- Completion of orders
-- Objective: Instead of just counting orders, calculating the percentage share of each status. For better better business context.
-- ===============================================
SELECT
    `Order Status`,
    COUNT(*) AS Total_Orders,
    ROUND(COUNT(*) * 100.0 / (
        SELECT COUNT(*)
        FROM datacosupplychain_clean
    ),2) AS Percentage
FROM datacosupplychain_clean
GROUP BY `Order Status`
ORDER BY Total_Orders DESC;
-- Observation:
-- About 32.96% of orders are completed with about 59491 orders


-- ===============================================
-- Business Question 7- Highest Delivery rate by shipping mode
-- Objective: to analyze which shiiping mode has the highest late delivery rate
-- ===============================================
SELECT
    `Shipping Mode`,
    COUNT(*) AS Total_Orders,
    SUM(
        CASE
            WHEN `Delivery Status` = 'Late delivery'
            THEN 1
            ELSE 0
        END
    ) AS Late_Deliveries,
    ROUND(
        SUM(
            CASE
                WHEN `Delivery Status` = 'Late delivery'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Late_Delivery_Percentage
FROM datacosupplychain_clean
GROUP BY `Shipping Mode`
ORDER BY Late_Delivery_Percentage DESC;
-- Observation:
-- First class delivery mode has the highest delivery rate about 95.32% of late deliveries out of 27814 orders Which is a major sign for improvement


-- ===============================================
-- Business Question 8
-- Which market experiences the highest late delivery rate?
-- ===============================================
SELECT
    Market,
    COUNT(*) AS Total_Orders,
    SUM(CASE
            WHEN `Delivery Status`='Late delivery'
            THEN 1
            ELSE 0
        END) AS Late_Deliveries,

    ROUND(
        SUM(CASE
                WHEN `Delivery Status`='Late delivery'
                THEN 1
                ELSE 0
            END)*100.0/COUNT(*),
        2
    ) AS Late_Delivery_Rate
FROM datacosupplychain_clean
GROUP BY Market
ORDER BY Late_Delivery_Rate DESC;
-- Observation:
-- Pacific Asia Market has the highest late delivery rate with about 55.05% late deliveries and USCA being the second highest 


-- ===============================================
-- Business Question 9
-- Are discounts helping or hurting profitability?
-- ===============================================
SELECT
    ROUND(`Order Item Discount Rate`*100,0) AS Discount_Percentage,
    ROUND(AVG(`Benefit per order`),2) AS Avg_Profit,
    COUNT(*) AS Orders
FROM datacosupplychain_clean
GROUP BY Discount_Percentage
ORDER BY Discount_Percentage;
-- Observation
-- Since profit decreases as discount percentage increases, the company may be sacrificing margin without gaining enough value.


-- ===============================================
-- Business Question 10
-- Which products generate high sales but low profit?
-- ===============================================
SELECT
    `Product Name`,
    ROUND(SUM(Sales),2) AS Sales,
    ROUND(SUM(`Benefit per order`),2) AS Profit
FROM datacosupplychain_clean
GROUP BY `Product Name`
ORDER BY Sales DESC
LIMIT 15;


-- ===============================================
-- Business Question 11
-- Which departments are affected by delivery delays?
-- ===============================================
SELECT
`Department Name`,
COUNT(*) AS Total_Orders,
SUM(
CASE
WHEN `Delivery Status`='Late delivery'
THEN 1
ELSE 0
END
) AS Late_Deliveries,
ROUND(
SUM(
CASE
WHEN `Delivery Status`='Late delivery'
THEN 1
ELSE 0
END
)*100/COUNT(*),2)
AS Delay_Rate
FROM datacosupplychain_clean
GROUP BY `Department Name`
ORDER BY Delay_Rate DESC;
-- Observation
-- Pet shop has the highest delay rate in delivery with around 58.94% of late deliveries out of 492 orders 


-- ===============================================
-- Business Question 12
-- Monthly Sales Trend
-- ===============================================
SELECT
    YEAR(`order date (DateOrders)`) AS Year,
    MONTH(`order date (DateOrders)`) AS Month_Number,
    MONTHNAME(`order date (DateOrders)`) AS Month_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM datacosupplychain_clean
GROUP BY
    YEAR(`order date (DateOrders)`),
    MONTH(`order date (DateOrders)`),
    MONTHNAME(`order date (DateOrders)`)
ORDER BY
    Year,
    Month_Number;
-- Observation
--  september 2017 has the highest sales over all the remaining months


-- ===============================================
-- Business Question 13
-- Which shipping mode generates the highest profit?
-- ===============================================
SELECT
`Shipping Mode`,
ROUND(SUM(`Benefit per order`),2) AS Profit,
ROUND(AVG(`Benefit per order`),2) AS Avg_Profit
FROM datacosupplychain_clean
GROUP BY `Shipping Mode`
ORDER BY Profit DESC;
-- Observation
-- Standrad class generates the highest profit
