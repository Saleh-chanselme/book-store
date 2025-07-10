-- 1. Affichez la somme totale des stocks de livres.
SELECT SUM(stock) AS totale_stocks
FROM book 
-- 2. Affichez pour chaque auteur le nombre de livres écrits.
SELECT a.first_name, a.last_name, COUNT(b.book_id) AS total_books
FROM author a
JOIN book b ON b.author_id = a.author_id
GROUP BY a.author_id, a.first_name, a.last_name;


-- 3. Affichez le titre du livre, nom complet de l’auteur, et nom du thème.
SELECT 
    b.title AS book_title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_full_name,
    t.theme_name AS theme_name
FROM book b
JOIN author a ON b.author_id = a.author_id
JOIN theme t ON b.theme_id = t.theme_id;



-- 4. Affichez toutes les commandes d’un client donné avec titre du livre et date de commande.
SELECT 
    total_amount,
    b.title AS book_title,
    o.order_date
FROM customer_order o
JOIN book b ON o.book_id = b.book_id
GROUP BY o.customer_id


-- 5. Affichez la moyenne des notes pour chaque livre ayant au moins 3 avis.
SELECT book_id, AVG(rating) AS average_rating
FROM review
WHERE rating >= 3
GROUP BY book_id;


-- 6. Affichez le nombre total de commandes passées par chaque client (email+nb commandes.
SELECT 
    c.email,
    COUNT(o.order_id) AS total_orders
FROM customer c
JOIN customer_order o ON c.customer_id = o.customer_id
GROUP BY c.email;



-- 7. Affichez les titres des livres qui n’ont jamais été commandés.
SELECT b.title, b.book_id  
FROM book b 
LEFT JOIN customer_order co ON b.book_id = co.book_id
WHERE co.book_id IS NULL

-- 8. Affichez le chiffre d’affaires total généré par chaque auteur (somme des prix des livres commandés).

SELECT 
    a.first_name,
    a.last_name,
    SUM(b.price) AS total_sales
FROM author a
JOIN book b ON b.author_id = a.author_id
JOIN customer_order o ON o.book_id = b.book_id
GROUP BY a.author_id, a.first_name, a.last_name;

