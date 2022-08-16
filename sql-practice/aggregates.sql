-- number of cats in the database
SELECT COUNT(id)
FROM cats;

--oldest cat and the year it was born
SELECT name, MIN(birth_year)
FROM cats;

--youngest cat and the year it was born
SELECT name, MAX(birth_year)
FROM cats;

--both combined
SELECT name, birth_year
FROM CATS
WHERE birth_year IN (
  (SELECT MIN(birth_year) FROM cats),
  (SELECT MAX(birth_year) FROM cats)
);


-- number of toys per cat
SELECT cats.name, COUNT(*)
FROM cats JOIN toys ON cats.id = toys.cat_id
GROUP BY cats.name;

-- cats with 2 or more toys
SELECT cats.name, COUNT(*)
FROM cats JOIN toys ON cats.id = toys.cat_id
GROUP BY cats.name
HAVING COUNT(*) >= 2;

-- toys belonging to Garfield using JOIN
SELECT toys.name FROM toys
JOIN cats on cats.id = toys.cat_id
WHERE cats.name = 'Garfield';

--using a subquery instead
SELECT toys.name FROM toys
WHERE toys.cat_id IN (
  SELECT cats.id FROM cats
  WHERE cats.name = 'Garfield'
);

--give Garfield a new toy named Pepperoni using a subquery for his id
INSERT INTO toys (name, cat_id)
SELECT 'Pepperoni', cats.id
FROM cats
WHERE cats.name = 'Garfield';

--give all cats born before the year 2013 a new toy named 'Cat Bed'
--using a subquery
INSERT INTO toys (name, cat_id)
  SELECT 'Cat Bed', cats.id
  FROM cats
  WHERE cats.birth_year < 2013;

--backup the cats table into cats_backup
CREATE TABLE cats_backup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  birth_year INTEGER
);
INSERT INTO cats_backup
SELECT * FROM cats;

--backup the toys table into toys_backup
CREATE TABLE toys_backup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  cat_id INTEGER,
  FOREIGN KEY (cat_id) REFERENCES cats_backup(id) ON DELETE CASCADE
);
INSERT INTO toys_backup
SELECT * FROM toys;
