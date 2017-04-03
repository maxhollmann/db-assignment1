-- Requires Oracle version >= 12c

-- 1
SELECT name, age FROM customer WHERE age < 18;

-- 2
SELECT NAME, age FROM customer WHERE age NOT BETWEEN 18 AND 65;

-- 3
SELECT DISTINCT s.cid
FROM sold_tickets s
INNER JOIN movie m ON (m.mid = s.mid
                       AND m.genre = 'thriller');

-- 4
SELECT c.name
FROM customer c
WHERE NOT EXISTS (SELECT s.*
                  FROM sold_tickets s
                  WHERE s.cid = c.cid);

-- 5
SELECT DISTINCT c.name, m.title
FROM customer c
INNER JOIN sold_tickets s ON c.cid = s.cid
INNER JOIN movie m ON (m.mid = s.mid
                       AND m.minage > c.age);

-- 6
SELECT c.name
FROM customer c
WHERE (SELECT COUNT(*)
       FROM sold_tickets s
       WHERE s.cid = c.cid) = (SELECT MAX(COUNT(*))
                               FROM sold_tickets smax
                               GROUP BY smax.cid);

-- 7
SELECT s.cid
FROM sold_tickets s
GROUP BY s.cid
HAVING COUNT(*) >= 2;

-- 8
SELECT m.director, AVG(c.age) AS avg_age
FROM movie m
INNER JOIN sold_tickets s ON m.mid = s.mid
INNER JOIN customer c ON c.cid = s.cid
GROUP BY m.director;

-- 9
SELECT t.city_name
FROM theater t
GROUP BY t.city_name
ORDER BY SUM(t.revenue) DESC
FETCH FIRST ROW ONLY;

-- 10
SELECT c.cid
FROM customer c
WHERE (SELECT COUNT(*)
       FROM (SELECT DISTINCT s.address, s.postalcode
             FROM sold_tickets s
             WHERE s.cid = c.cid)) = 1;

-- 11
SELECT c.cid
FROM customer c
WHERE (SELECT COUNT(*)
       FROM (SELECT DISTINCT s.address, s.postalcode
             FROM sold_tickets s
             WHERE s.cid = c.cid)) > 1;

-- 12
SELECT t.address, t.postalcode, m.title
FROM theater t
INNER JOIN movie m ON (EXISTS (SELECT *
                               FROM sold_tickets s
                               WHERE (s.mid = m.mid
                                      AND s.postalcode = t.postalcode AND s.address = t.address))
                       AND (SELECT COUNT(*)
                            FROM sold_tickets s
                            WHERE (s.mid = m.mid
                                   AND s.postalcode = t.postalcode AND s.address = t.address))
                         = (SELECT MAX(COUNT(*))
                            FROM sold_tickets s
                            WHERE (s.postalcode = t.postalcode AND s.address = t.address)
                            GROUP BY s.mid));

-- 13
SELECT g.address, g.postalcode, AVG(g.vcount)
FROM (SELECT t.address, t.postalcode, COUNT(*) AS vcount
      FROM theater t
      INNER JOIN sold_tickets s ON (s.postalcode = t.postalcode AND s.address = t.address)
      GROUP BY s.mid, t.postalcode, t.address) g
GROUP BY g.address, g.postalcode;

-- 14
SELECT t.address, t.postalcode
FROM theater t
ORDER BY t.revenue ASC
OFFSET 1 ROW FETCH FIRST ROW ONLY;


-- 15
SELECT c.cid
FROM customer c
WHERE (SELECT COUNT(DISTINCT s.mid)
       FROM sold_tickets s
       WHERE s.cid = c.cid)
    = (SELECT COUNT(*) FROM movie);
