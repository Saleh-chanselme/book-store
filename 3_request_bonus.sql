-- Bonus SQL

-- 1. Trouver les 3 auteurs dont les livres ont généré le plus de chiffre d’affaires total.
SELECT 
    a.author_id,
    a.first_name,
    a.last_name,
    SUM(b.price) AS total_sales
FROM author a
JOIN book b ON b.author_id = a.author_id
JOIN customer_order o ON o.book_id = b.book_id
GROUP BY a.author_id, a.first_name, a.last_name
ORDER BY total_sales DESC
LIMIT 3;


-- 2. Calculer le total des ventes par thème de livre, classé du plus au moins vendu (en montant).
SELECT 
    t.theme_name,
    SUM(b.price) AS total_sales
FROM theme t
JOIN book b ON b.theme_id = t.theme_id
JOIN customer_order o ON o.book_id = b.book_id
GROUP BY t.theme_name
ORDER BY total_sales DESC;


-- 3. Afficher pour chaque mois de l’année 2024 le nombre de commandes passées et le chiffre d’affaires total.

SELECT 
    strftime('%Y-%m', o.order_date) AS month,
    COUNT(o.order_id) AS total_orders,
    SUM(b.price) AS total_sales
FROM customer_order o
JOIN book b ON o.book_id = b.book_id
WHERE strftime('%Y', o.order_date) = '2024'
GROUP BY month
ORDER BY month;


-- 4. Pour chaque auteur, calculer la moyenne des notes des livres écrits, y compris les auteurs dont livres n’ont pas encore d’avis (afficher NULL dans ce cas).
SELECT 
    a.author_id,
  CONCAT(a.first_name, ' ', a.last_name) AS author_full_name,
    AVG(r.rating) AS average_rating

FROM author a
 JOIN book b ON a.author_id = b.author_id
LEFT JOIN review r ON b.book_id = r.book_id
GROUP BY a.author_id, a.first_name, a.last_name;

-- 5. Afficher les commandes les plus récentes pour chaque client (1 commande max par client).
SELECT 
    c.customer_id,
    c.email,
    o.order_id,
    o.order_date,
    o.book_id
FROM customer c
JOIN customer_order o ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM customer_order o2
    WHERE o2.customer_id = c.customer_id
);
