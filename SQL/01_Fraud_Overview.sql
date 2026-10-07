-- Fraud Overview Analysis
-- Behavioral Fraud Analytics Project

-- 1. Total transactions
SELECT
    COUNT(transaction_id) AS total_transactions
FROM train_data;


-- 2. Fraud vs legitimate transactions
SELECT
    label,
    COUNT(transaction_id) AS total_transactions
FROM train_data
GROUP BY label;


-- 3. Total transaction amount
SELECT
    SUM(amount) AS total_transaction_amount
FROM train_data;


-- 4. Fraud amount
SELECT
    SUM(amount) AS fraud_amount
FROM train_data
WHERE label = 1;


-- 5. Overall fraud rate
SELECT
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate
FROM train_data;
