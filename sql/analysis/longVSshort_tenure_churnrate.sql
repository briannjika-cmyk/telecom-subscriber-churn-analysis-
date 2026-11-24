-- Compare churn among customers who have stayed for 12 months or less
-- with customers who have stayed for more than 48 months.

SELECT
    CASE
        WHEN tenure <= 12 THEN 'Short tenure'
        WHEN tenure > 48 THEN 'Long tenure'
    END AS tenure_category,

    COUNT(*) AS total_customers,

    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS churn_rate

FROM subscribers
WHERE tenure <= 12 OR tenure > 48
GROUP BY tenure_category;