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
