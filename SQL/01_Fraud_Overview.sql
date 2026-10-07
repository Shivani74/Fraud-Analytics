SELECT TOP 10 *
FROM dbo.train_data;

Select count(*) as total_transactions
from dbo.train_data;

Select label, count(transaction_id) as total_transactions
from dbo.train_data
group by label;

Select sum(amount) as fraud_amount
from dbo.train_data
where label = 1;

Select count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data;

Select country, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by country
order by fraud_rate desc;

Select merchant_category, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by merchant_category
order by fraud_rate desc;

Select user_id, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transactions,
sum(amount) as total_amount
from dbo.train_data
group by user_id
order by fraud_transactions desc;

Select user_id, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by user_id
order by fraud_rate desc;

Select user_id, count(transaction_id) as total_transactions,
sum(case when label = 1 then 1 Else 0 End) as fraud_transactions,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by user_id
having sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) >= 50
order by fraud_rate desc;

Select top 10 user_id, sum(case when label = 1 then 1 Else 0 End) as fraud_transactions
from dbo.train_data
group by user_id
order by fraud_transactions desc;

Select country, sum(case when label = 1 then amount Else 0 End) as fraud_amount
from dbo.train_data
group by country
order by fraud_amount desc;

Select label, count(transaction_id) as total_transactions, 
avg(amount) as avg_amount
from dbo.train_data
group by label;

SELECT MAX(amount) AS maximum_transaction_amount
FROM dbo.train_data;

Select transaction_id, merchant_category, amount, label, country, user_id
from dbo.train_data
where amount>1000
order by amount desc;

Select channel, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by channel
order by fraud_rate desc;

Select top 10 device_id, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by device_id
order by fraud_rate desc;

Select top 1 merchant_category, count(transaction_id) as total_transaction,
sum(case when label = 1 then 1 Else 0 End) as fraud_transaction,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate 
from dbo.train_data
group by merchant_category
order by fraud_rate desc;

Select user_id, count(transaction_id) as total_transactions,
sum(case when label = 1 then 1 Else 0 End) as fraud_transactions,
sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) as fraud_rate,
case when sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) >= 50 then 'High Risk'
 when sum(case when label = 1 then 1 Else 0 End)*100/ count(transaction_id) >= 50 then 'Medium Risk'
 Else 'Low Risk'
 End as risk_category
 from dbo.train_data
 Group by user_id
 Order by fraud_rate Desc;

With user_fraud as 
(
  Select user_id, count(transaction_id) as total_transactions,
sum(case when label = 1 then 1 Else 0 End) as fraud_transactions,
sum(amount) as total_amount,
avg(amount) as average_amount
from dbo.train_data
group by user_id
)
Select user_id, total_transactions, fraud_transactions, total_amount, average_amount, fraud_transactions*100 / total_transactions as fraud_rate,
Case when fraud_transactions *100/ total_transactions >=50 then 'High Risk'
when fraud_transactions *100/ total_transactions >=20 then 'Medium Risk'
Else 'Low Risk'
End as Risk_Category
from user_fraud
order by fraud_rate Desc;

SELECT
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 0 THEN 1 ELSE 0 END) AS legitimate_transactions,
    SUM(amount) AS total_transaction_amount,
    SUM(CASE WHEN label = 1 THEN amount ELSE 0 END) AS fraud_amount,
    AVG(amount) AS average_transaction_amount,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate
FROM dbo.train_data;

CREATE VIEW dbo.vw_fraud_summary AS
SELECT
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 0 THEN 1 ELSE 0 END) AS legitimate_transactions,
    SUM(amount) AS total_transaction_amount,
    SUM(CASE WHEN label = 1 THEN amount ELSE 0 END) AS fraud_amount,
    AVG(amount) AS average_transaction_amount,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate
FROM dbo.train_data;

CREATE VIEW dbo.vw_country_fraud AS
SELECT
    country,
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate,
    SUM(CASE WHEN label = 1 THEN amount ELSE 0 END) AS fraud_amount
FROM dbo.train_data
GROUP BY country;

SELECT *
FROM dbo.vw_country_fraud
ORDER BY fraud_rate DESC;

CREATE VIEW dbo.vw_merchant_fraud AS
SELECT
    merchant_category,
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate,
    SUM(CASE WHEN label = 1 THEN amount ELSE 0 END) AS fraud_amount
FROM dbo.train_data
GROUP BY merchant_category;

SELECT *
FROM dbo.vw_merchant_fraud
ORDER BY fraud_rate DESC;

CREATE VIEW dbo.vw_user_risk AS
SELECT
    user_id,
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate,
    CASE
        WHEN SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
             / COUNT(transaction_id) >= 50
            THEN 'High Risk'
        WHEN SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
             / COUNT(transaction_id) >= 20
            THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM dbo.train_data
GROUP BY user_id;

SELECT TOP 20 *
FROM dbo.vw_user_risk
ORDER BY fraud_rate DESC;

CREATE OR ALTER VIEW dbo.vw_user_risk AS
SELECT
    user_id,
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,

    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate,

    CASE
        WHEN SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
             / COUNT(transaction_id) >= 5
            THEN 'High Risk'

        WHEN SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
             / COUNT(transaction_id) >= 2
            THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_category

FROM dbo.train_data
GROUP BY user_id;

SELECT COUNT(transaction_id) AS total_transactions
FROM train_data;

SELECT label, COUNT(transaction_id) AS total_transactions
FROM train_data
GROUP BY label;

SELECT SUM(amount) AS fraud_amount
FROM train_data
WHERE label = 1;


SELECT
    country,
    COUNT(transaction_id) AS total_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate
FROM train_data
GROUP BY country;

SELECT TOP 1
    merchant_category,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(transaction_id) AS fraud_rate
FROM train_data
GROUP BY merchant_category
ORDER BY fraud_rate DESC;














WITH user_fraud AS
(
    SELECT
        user_id,
        COUNT(transaction_id) AS total_transactions,
        SUM(CASE WHEN label = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
        SUM(amount) AS total_amount,
        AVG(amount) AS average_amount
    FROM train_data
    GROUP BY user_id
),
user_fraud_rate AS
(
    SELECT
        user_id,
        total_transactions,
        fraud_transactions,
        total_amount,
        average_amount,
        fraud_transactions * 100.0 / total_transactions AS fraud_rate
    FROM user_fraud
)
SELECT
    user_id,
    total_transactions,
    fraud_transactions,
    fraud_rate,
    total_amount,
    average_amount,
    CASE
        WHEN fraud_rate >= 50 THEN 'High Risk'
        WHEN fraud_rate >= 20 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM user_fraud_rate;
