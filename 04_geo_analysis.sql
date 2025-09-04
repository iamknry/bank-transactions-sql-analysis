SET search_path TO bank, public;

-- Top 10 states by total transaction amount
SELECT 
    merchant_state AS state,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY merchant_state
ORDER BY total_amount DESC
LIMIT 10;

-- Top 10 cities by average transaction amount
SELECT 
    merchant_city AS city,
    ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
GROUP BY merchant_city
ORDER BY avg_amount DESC
LIMIT 10;