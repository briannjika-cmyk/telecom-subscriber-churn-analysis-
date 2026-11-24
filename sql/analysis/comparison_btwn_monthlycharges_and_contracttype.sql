-- Compare each churned customer's monthly charges with the
-- average monthly charges of customers on the same contract type.

SELECT
    customerID,
    Contract,
    MonthlyCharges,

    ROUND(
        AVG(MonthlyCharges) OVER (
            PARTITION BY Contract
        ), 2
    ) AS contract_average_charges,

    ROUND(
        MonthlyCharges - AVG(MonthlyCharges) OVER (
            PARTITION BY Contract
        ), 2
    ) AS difference_from_average

FROM subscribers

WHERE Churn = 'Yes'

ORDER BY Contract, difference_from_average DESC;