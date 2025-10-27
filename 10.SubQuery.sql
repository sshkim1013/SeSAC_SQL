USE world;

-- 서울 인구
SELECT Population FROM city WHERE Name = 'Seoul';

-- 서울 인구보다 많은 도시 

SELECT *
FROM city
WHERE population > (SELECT Population FROM city WHERE Name = 'Seoul');

SELECT
	Name,
    Population
FROM country
WHERE Population > (SELECT AVG(Population) FROM country)
ORDER BY Population DESC;

SELECT Code
FROM Country
WHERE Continent = 'Asia';

SELECT 
	Name,
    CountryCode,
    Population
FROM city
WHERE CountryCode IN (SELECT Code FROM Country WHERE Continent = 'Asia');

SELECT DISTINCT CountryCode
FROM city;

SELECT *
FROM Country
WHERE Code NOT IN (SELECT DISTINCT CountryCode FROM city);

-- 국가가 40개 이상인 대륙들만 추출.
SELECT *
FROM (
	SELECT Continent, COUNT(*) AS co_count
    FROM country 
    GROUP BY Continent
) continent_table
WHERE co_count > 40;


-- 아래부터는 실습!

USE sakila;

-- 평균 대여료(`rental_rate`)보다 비싼 영화를 조회하세요.
-- - 영화 제목, 대여료. 대여료 내림차순 정렬
-- - 상위 10개
SELECT
	title 제목,
    rental_rate 대여료
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC
LIMIT 10;

-- 'Action' 카테고리에 속한 영화를 조회하세요.
-- - 영화 제목
SELECT title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id = (
		SELECT category_id
		FROM category
		WHERE name = 'Action')
	);

-- 대여 기록이 있는 고객만 조회하세요.
-- - 고객 이름 (first_name, last_name), 이메일
SELECT
	first_name 이름,
    last_name 성,
    email 이메일
FROM customer c
WHERE 
	EXISTS (SELECT *
			FROM rental r
			WHERE c.customer_id = r.customer_id
            );

-- 고객별 대여 횟수를 구한 뒤, 대여 횟수가 30회 이상인 고객만 조회하세요.
-- - 고객 이름, 대여 횟수, 대여 횟수 내림차순
SELECT 이름, 성, 대여횟수
FROM (SELECT 
		c.first_name 이름,
		c.first_name 성,
		COUNT(*) 대여횟수
	  FROM customer c INNER JOIN rental r
		   ON c.customer_id = r.customer_id
	  GROUP BY c.customer_id
) customer_rental
WHERE 대여횟수 >= 30
ORDER BY 대여횟수 DESC;