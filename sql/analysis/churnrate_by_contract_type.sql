-- Compare each contract's churn rate against the overall churn rate.
-- A positive difference means the contract has above-average churn.
-- A negative difference means it has below-average churn.

WITH overall AS (
    SELECT
        ROUND(
            SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*), 2
        ) AS overall_churn_rate
    FROM subscribers
),

contract_analysis AS (
    SELECT
        Contract,
        COUNT(*) AS total_customers,

        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
            AS churned_customers,

        ROUND(
            SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
            * 100.0 / COUNT(*), 2
        ) AS contract_churn_rate

    FROM subscribers
    GROUP BY Contract
)

SELECT
    c.Contract,
    c.total_customers,
    c.churned_customers,
    c.contract_churn_rate,
    o.overall_churn_rate,

    ROUND(
        c.contract_churn_rate - o.overall_churn_rate, 2
    ) AS difference_percentage_points

FROM contract_analysis c
CROSS JOIN overall o
ORDER BY c.contract_churn_rate DESC;