USE world;

SELECT * FROM country;

-- GROUP BY : 특정 컬럼 값이 같은 row끼리 그루핑
-- COUNT(*)을 사용할 수 있다.
SELECT Continent, COUNT(*) FROM country
GROUP BY Continent;

SELECT Continent, COUNT(*) FROM country
GROUP BY Continent ORDER BY COUNT(*) DESC;

SELECT 
	Continent,
    COUNT(*),
    ROUND(AVG(Population) / 1000000) AS 인구수,
    AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY 인구수 DESC;


SELECT 
	Continent,
    Region,
    COUNT(*)
FROM country
GROUP BY Continent, Region
ORDER BY Continent, COUNT(*) DESC;


-- HAVING 절 학습.

-- WHERE : GROUP BY 이전에 필터링.
SELECT Continent, COUNT(*)
FROM country
WHERE Population >= 100000000
GROUP BY Continent;

-- HAVING : GROUP BY로 묶은 결과에서 필터링.
SELECT Continent AS 대륙, 
	   ROUND(AVG(Population)) AS "평균 인구수"
FROM country
GROUP BY Continent
HAVING AVG(Population) >= 20000000;


-- 아래부터는 실습

USE sakila;
SELECT * FROM film;

-- 등급(rating)별로 다음 정보를 조회하세요:
-- - 등급, 영화 개수
-- - 영화 개수가 많은 순서로 정렬

SELECT rating, COUNT(*)
FROM film
GROUP BY rating
ORDER BY COUNT(*) DESC;

-- 등급(rating)별로 다음 정보를 조회하세요:
-- - 등급
-- - 영화 개수
-- - 평균 대여료 (소수점 둘째 자리)
-- - 최고 대여료
-- - 최저 대여료
-- - 평균 대여료 내림차순 정렬
SELECT 
	 rating,
     COUNT(*),
     ROUND(AVG(rental_rate), 2) 대여료,
     MAX(rental_rate),
     MIN(rental_rate)
FROM film
GROUP BY rating
ORDER BY 대여료 DESC;

-- 등급별 통계에서 영화가 200개 이상인 등급만 조회하세요:
-- - 등급
-- - 영화 개수
-- - 평균 대여료
SELECT 
	 rating, 
     COUNT(*), 
     AVG(rental_rate)
FROM film
GROUP BY rating
HAVING COUNT(*) >= 200;

-- 대여료가 2.99 이상인 영화만 집계하여, 등급별 통계를 조회하세요.
-- 단, 해당 등급의 영화가 50개 이상인 경우만 표시:
-- - 등급
-- - 영화 개수
-- - 평균 대여료
SELECT 
	 rating,
     COUNT(*),
     AVG(rental_rate)
FROM film
WHERE rental_rate >= 2.99
GROUP BY rating
HAVING COUNT(*) >= 50;

-- 배우(actor) 테이블에서 성(last_name)별 배우 수를 조회하세요:
-- - 성
-- - 배우 수
-- - 배우가 2명 이상인 성만 표시
-- - 배우 수 내림차순 정렬
SELECT * FROM actor;

SELECT 
	 last_name,
     COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC;
