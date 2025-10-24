USE world;

SELECT * FROM country
ORDER BY Population DESC;

SELECT * FROM country
ORDER BY Name DESC;

-- Continent 정렬을 먼저한 뒤, 그 내부에서 Population 순으로 정렬
SELECT * FROM country
ORDER BY Continent DESC, Population DESC;

SELECT * FROM country
WHERE Continent = 'Asia'
ORDER BY GNP;

SELECT * FROM country
ORDER BY Population DESC
LIMIT 5;

-- 11번째 행부터 20번째 행까지 출력
SELECT * FROM country
ORDER BY Population DESC
LIMIT 5 OFFSET 10;

-- 축약 문법
SELECT * FROM country
ORDER BY Population DESC
LIMIT 10, 5;