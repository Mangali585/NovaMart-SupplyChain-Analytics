-- =====================================================
-- Advanced Query 1
-- Rank Markets by Revenue
-- =====================================================
SELECT
    Market,
    ROUND(SUM(Sales),2) AS Total_Sales,
    RANK() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS Market_Rank
FROM datacosupplychain_clean
GROUP BY Market;


-- =====================================================
-- Advanced Query 2
-- Rank Markets by Revenue(using dense rank)
-- =====================================================
SELECT
    Market,
    ROUND(SUM(Sales),2) AS Revenue,
    DENSE_RANK() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS DenseRank
FROM datacosupplychain_clean
GROUP BY Market;


-- =====================================================
-- Advanced Query 3
-- Top product in every category (CTE)
-- =====================================================
WITH ProductSales AS
(
SELECT
    `Category Name`,
    `Product Name`,
    ROUND(SUM(Sales),2) AS Revenue
FROM datacosupplychain_clean
GROUP BY
`Category Name`,
`Product Name`
)
SELECT *
FROM ProductSales;

-- CTE2
WITH ProductSales AS
(
SELECT
`Category Name`,
`Product Name`,
ROUND(SUM(Sales),2) Revenue
FROM datacosupplychain_clean
GROUP BY
`Category Name`,
`Product Name`
)
SELECT *
FROM
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Category Name`
ORDER BY Revenue DESC
) AS rn
FROM ProductSales
)t
WHERE rn=1;


-- =====================================================
-- Advanced Query 4
-- Running daily sales 
-- =====================================================
SELECT
DATE(`order date (DateOrders)`) AS Order_Date,
ROUND(SUM(Sales),2) Daily_Sales,
ROUND(
SUM(SUM(Sales))
OVER(
ORDER BY DATE(`order date (DateOrders)`)
),2)
AS Running_Total
FROM datacosupplychain_clean
GROUP BY DATE(`order date (DateOrders)`);


-- =====================================================
-- Advanced Query 5
-- Top 5 Customers by Revenue
-- =====================================================
SELECT
`Customer Id`,
CONCAT(`Customer Fname`,
' ',
`Customer Lname`) AS Customer_Name,
ROUND(SUM(Sales),2) Revenue,
ROW_NUMBER()
OVER(
ORDER BY SUM(Sales) DESC
)
AS Rank_No
FROM datacosupplychain_clean
GROUP BY
`Customer Id`,
Customer_Name
LIMIT 5;