/* 1 */
SELECT name, age FROM customer WHERE age < 18;

/* 2 */
SELECT NAME, age FROM customer WHERE age NOT BETWEEN 18 AND 65;

/* 3 */
SELECT DISTINCT c.cid
FROM customer c
INNER JOIN sold_tickets s ON c.cid = s.cid
INNER JOIN movie m ON (m.mid = s.mid
                       AND m.genre = 'thriller');

/* 4 */
SELECT c.name
FROM customer c
WHERE (SELECT COUNT(*)
       FROM sold_tickets s
       WHERE s.cid = c.cid) = 0;

/* 5 */
SELECT DISTINCT c.name, m.title
FROM customer c
INNER JOIN sold_tickets s ON c.cid = s.cid
INNER JOIN movie m ON (m.mid = s.mid
                       AND m.minage > c.age);

/* 6 */
SELECT c.name
FROM customer c
WHERE (SELECT COUNT(*)
       FROM sold_tickets s
       WHERE s.cid = c.cid) = (SELECT MAX(COUNT(*))
                               FROM sold_tickets smax
                               GROUP BY smax.cid);

/* 7 */
SELECT s.cid
FROM sold_tickets s
GROUP BY s.cid
HAVING COUNT(*) >= 2;

/* 8 CHECK */
SELECT m.director, AVG(c.age)
FROM movie m
INNER JOIN sold_tickets s ON m.mid = s.mid
INNER JOIN customer c ON c.cid = s.cid
GROUP BY m.director;

/* 9 */
SELECT t.city_name
FROM sold_tickets s
INNER JOIN theater t ON (t.postalcode = s.postalcode AND t.address = s.address)
GROUP BY t.city_name
ORDER BY COUNT(*) DESC
FETCH FIRST ROW ONLY;

/* 10 WRONG */
SELECT c.cid
FROM customer c
INNER JOIN sold_tickets s ON c.cid = s.cid
GROUP BY (c.cid, s.postalcode, s.address)
HAVING COUNT(*) = 1;
