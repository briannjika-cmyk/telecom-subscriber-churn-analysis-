-- Group customers according to their combinations of security,
-- backup, device protection and technical support subscriptions.
-- This helps identify service combinations associated with higher churn.

SELECT
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,

    COUNT(*) AS total_customers,

    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,

    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS churn_rate

FROM subscribers
GROUP BY
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport

HAVING COUNT(*) >= 30

ORDER BY churn_rate DESC;