SET search_path TO bank,public;

-- Average credit limit by card brands
SELECT
		card_brand AS card_brands,
		ROUND(AVG(credit_limit),2) AS avg_credit_limit
FROM cards
GROUP BY card_brand
ORDER BY avg_credit_limit DESC;

-- Income and credit limit correlation
SELECT corr(u.yearly_income, c.credit_limit) AS income_limit_corr
FROM bank.users AS u
JOIN bank.cards AS c
    ON u.id = c.client_id;

-- Average total debt by credit score range (480-850)
SELECT
    	credit_score_range,
    	ROUND(AVG(total_debt), 2) AS avg_total_debt,
    	COUNT(*) AS users_count
FROM (SELECT
        	CASE
            	WHEN credit_score BETWEEN 480 AND 579 THEN 'Poor (480-579)'
            	WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair (580-669)'
            	WHEN credit_score BETWEEN 670 AND 739 THEN 'Good (670-739)'
            	WHEN credit_score BETWEEN 740 AND 799 THEN 'Very Good (740-799)'
            	WHEN credit_score BETWEEN 800 AND 850 THEN 'Excellent (800-850)'
            	ELSE 'Unknown'
        	END AS credit_score_range,
        	total_debt
		FROM bank.users)
GROUP BY credit_score_range
ORDER BY 
    	CASE 
        	WHEN credit_score_range = 'Poor (480-579)' THEN 1
        	WHEN credit_score_range = 'Fair (580-669)' THEN 2
        	WHEN credit_score_range = 'Good (670-739)' THEN 3
        	WHEN credit_score_range = 'Very Good (740-799)' THEN 4
        	WHEN credit_score_range = 'Excellent (800-850)' THEN 5
        	ELSE 6
    	END;

-- Share of negative transactions
SELECT 
    ROUND(COUNT(CASE 
					WHEN amount < 0 THEN 1 
				END)::numeric / COUNT(*) * 100,2) AS pct_negative_transactions
FROM transactions;