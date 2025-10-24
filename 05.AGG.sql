USE world;

SELECT * FROM country;

-- COUNT() : 전체 행의 갯수를 반환.
-- NULL 데이터는 제외하고 카운팅 한다.
SELECT COUNT(*) AS 모든국가의수 FROM country;
SELECT COUNT(LifeExpectancy) FROM country;
-- 중복제거 키워드인 DISTINCT도 내부에 포함 가능하다.
SELECT COUNT(DISTINCT Continent) FROM country;
SELECT COUNT(DISTINCT Region) FROM country;

-- SUM() : Population 컬럼의 합계를 반환한다.
SELECT SUM(Population) FROM country;
SELECT SUM(Population) FROM country
WHERE Continent = 'Asia';

SELECT SUM(Population) FROM country
WHERE Population >= 100000000;

-- ROUND() : 소수점 반올림 문법.
-- 소수점 3번째 자리까지 나타내는 예제.
SELECT ROUND(SUM(SurfaceArea) / 10000, 3) FROM country;

-- AVG() : 평균 구하는 문법.
SELECT AVG(Population) FROM country;
SELECT AVG(Population) FROM country WHERE Continent = 'Asia';

-- 서브 쿼리.
SELECT * FROM country
WHERE Population = (SELECT MAX(Population) FROM country);

SELECT
	COUNT(*),
    SUM(Population),
    AVG(Population),
    MAX(Population),
    MIN(Population)
FROM country;

SELECT LifeExpectancy FROM country;
SELECT AVG(LifeExpectancy) FROM country;

-- COALESCE() : NULL 값을 특정 값으로 대체하는 문법.
-- LifeExpectancy 값이 NULL이면 50이라는 값을 사용한다.
SELECT AVG(COALESCE(LifeExpectancy, 50)) FROM country;



-- 아래부터는 실습

USE sakila;
SELECT * FROM film;

-- 전체 영화 개수
SELECT COUNT(*) AS 전체영화개수 FROM film;

-- 등급(rating)이 'PG'인 영화 개수
SELECT COUNT(*) FROM film WHERE rating='PG';

-- 서로 다른 등급(rating)의 개수
SELECT COUNT(DISTINCT rating) FROM film;

-- 모든 영화의 대여료(rental_rate) 합계
SELECT SUM(rental_rate) FROM film;

-- 모든 영화의 평균 대여료 (소수점 둘째 자리)
SELECT ROUND(AVG(rental_rate), 2) FROM film;

-- 등급이 'R'인 영화의 평균 대여료
SELECT AVG(rental_rate) FROM film WHERE rating = 'R';

-- 가장 비싼 대여료와 해당 영화 제목
SELECT title, rental_rate
FROM film
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);

-- 가장 긴 상영 시간(length)과 해당 영화 제목
SELECT title, length
FROM film
WHERE length = (SELECT MAX(length) FROM film);

-- 가장 짧은 상영 시간과 해당 영화 제목
SELECT title, length
FROM film
WHERE length = (SELECT MIN(length) FROM film);

-- film 테이블의 다음 통계를 한 번에 조회하세요
-- 전체 영화 수, 총 대여료 합계, 평균 대여료, 최고 대여료, 최저 대여료, 평균 상영 시간
SELECT
	COUNT(*),
    SUM(rental_rate),
    AVG(rental_rate),
    MAX(rental_rate),
    MIN(rental_rate),
    AVG(length)
FROM film;