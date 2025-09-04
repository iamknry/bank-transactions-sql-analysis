SET search_path TO bank, public;

-- Transaction summary metrics
SELECT
		COUNT(DISTINCT t.id) AS total_transactions,
		SUM(t.amount) AS total_amount,
		ROUND(AVG(t.amount),2) AS avg_transaction_amount
FROM transactions AS t;

-- Transactions by type (chip / swipe / online)
SELECT
		t.use_chip AS transaction_type,
		COUNT(DISTINCT t.id) AS total_transactions,
		SUM(t.amount) AS total_amount
FROM transactions AS t
GROUP BY t.use_chip
ORDER BY total_transactions DESC;

-- Total transaction amount by year
SELECT 
    	DATE_TRUNC('year', t.date)::date AS year,
    	SUM(t.amount) AS total_amount
FROM transactions AS t
GROUP BY DATE_TRUNC('year', t.date)::date
ORDER BY year;

-- Top 10 merchants by total transaction amount
SELECT
		t.merchant_id AS merchant_id,
		SUM(t.amount) AS total_amount
FROM transactions AS t
GROUP BY t.merchant_id
ORDER BY total_amount DESC
LIMIT 10;