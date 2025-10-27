USE world;

SELECT * 
FROM city 
WHERE CountryCode = 'KOR';

SELECT * 
FROM country
WHERE Code = 'KOR';

SELECT 
	ci.Name 도시명,
    co.Name 국가명,
    co.Continent 소속대륙,
    co.Population 국가인구,
    ci.Population 도시인구,
    ROUND((ci.Population / co.Population) * 100, 2) 도시인구비율
FROM city ci INNER JOIN country co
	ON ci.CountryCode = co.Code
WHERE co.Name = 'South Korea';

SELECT 
	co.Name 국가명,
	COUNT(*) 도시개수
FROM city ci INNER JOIN country co
	ON ci.countrycode = co.code
GROUP BY co.Name
ORDER BY 2 DESC;

SELECT 
	co.continent 대륙명,
	COUNT(*) 대륙별도시개수,
    AVG(ci.population) 평균인구수
FROM city ci INNER JOIN country co
	ON ci.countrycode = co.code
GROUP BY co.continent;

SELECT 
	COUNT(DISTINCT co.code) '전체국가수_join',
    (SELECT COUNT(*) FROM country) '전체국가수_country'
FROM city ci INNER JOIN country co
	ON ci.countrycode = co.code;
    
SELECT *
FROM country co INNER JOIN city ci
	ON co.code = ci.countrycode
ORDER BY co.population;

SELECT 
	c1.name,
	c2.name
FROM city c1 INNER JOIN city c2
	ON c1.ID = c2.ID
WHERE c1.countrycode = 'KOR';

-- 3개 테이블 조인
SELECT *
FROM country co INNER JOIN city ci 
	ON co.code = ci.countrycode INNER JOIN countryLanguage cl
    ON ci.countrycode = cl.countrycode;
    
    
-- 아래부터는 실습
USE WORLD;

SELECT * FROM city WHERE CountryCode = 'KOR';
SELECT * FROM country WHERE Code = 'KOR';


SELECT
	ci.Name AS 도시명,
    co.Name AS 나라이름,
    co.Continent AS 대륙,
    ci.Population AS 도시인구,
    co.Population AS 국가인구,
    ci.Population / co.Population AS 도시인구비율
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
WHERE co.Name = 'South Korea';


SELECT 
	co.Name,
    COUNT(*)
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY COUNT(*) DESC;



SELECT
	co.Continent,
    COUNT(*),
    AVG(ci.Population)
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code
GROUP BY co.Continent;


SELECT
	COUNT(DISTINCT co.Code) AS '전체국가수_join',
    (SELECT COUNT(*) FROM country) AS '전체국가수_country'
FROM city ci INNER JOIN country co
ON ci.CountryCode = co.Code;

SELECT
	*
FROM country co LEFT JOIN city ci
ON co.Code = ci.CountryCode
ORDER BY co.Population;


SELECT
	c1.Name, c2.Name
FROM city c1 INNER JOIN city c2
ON c1.ID = c2.ID
WHERE c1.CountryCode = 'KOR';



SELECT
	*
FROM country co INNER JOIN city ci ON co.Code = ci.CountryCode
				INNER JOIN countrylanguage cl ON ci.CountryCode = cl.CountryCode;


-- 아래부터는 실습!
USE sakila;
SELECT * FROM film;
SELECT * FROM language;

-- 영화(`film`)와 언어(`language`) 테이블을 조인하여 다음을 조회하세요:
-- - 영화 제목 (`film.title`), 언어 이름 (`language.name`)
SELECT 
	f.title 영화제목, 
	l.name 언어이름
FROM film f INNER JOIN language l
	ON f.language_id = l.language_id;

-- 영화와 카테고리를 조인하여 다음을 조회하세요:
-- - 영화 제목, 카테고리 이름, 대여료
SELECT
	f.title 영화제목,
    c.name 카테고리분류,
    f.rental_rate 대여료
FROM film f INNER JOIN film_category fc
	ON f.film_id = fc.film_id INNER JOIN category c
    ON fc.category_id = c.category_id;

-- 모든 고객(`customer`)과 그들의 대여 내역(`rental`)을 조회하세요.
-- - 고객 이름 (first_name, last_name), 대여 ID (rental_id), 대여 날짜 (rental_date)
SELECT 
	c.first_name,
    c.last_name,
    r.rental_id,
    r.rental_date
FROM customer c INNER JOIN rental r
	ON c.customer_id = r.customer_id;

-- 고객별 대여 횟수를 조회하세요. (대여 횟수 0인 고객도 포함)
-- - 고객 이름, 대여 횟수, 대여 횟수가 많은 순서
SELECT 
	c.customer_id 고객ID,
	c.first_name 이름,
    c.last_name 성,
    COUNT(*) 대여횟수
FROM customer c INNER JOIN rental r
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY 4 DESC;

-- 같은 상영 시간(`length`)을 가진 영화 쌍을 찾으세요.
-- - 영화1 제목, 영화2 제목, 상영 시간, 상위 10개
SELECT
	f1.title '영화1 제목',
    f1.length '영화1 상영시간',
    f2.title '영화2 제목',
    f2.length '영화2 상영시간'
FROM film f1 INNER JOIN film f2
	ON f1.length = f2.length
LIMIT 10;