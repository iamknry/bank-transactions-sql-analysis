SET search_path TO bank, public;

-- Cards, users and transactions summary by brand
SELECT 
		c.card_brand AS card_brand,
		COUNT(DISTINCT u.id) AS number_of_users,
		COUNT(DISTINCT c.id) AS number_of_cards,
		COUNT(DISTINCT t.id) AS number_of_transactions,
		ROUND(COUNT(DISTINCT c.id)/COUNT(DISTINCT u.id),2) AS avg_cards_per_user
FROM users AS u
JOIN cards AS c
	ON c.client_id=u.id
JOIN transactions AS t
	ON t.client_id=u.id
GROUP BY c.card_brand;