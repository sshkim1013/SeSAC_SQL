USE world;

-- large_country 라는 VIEW에 다음 내용을 넣는다.
CREATE VIEW large_country AS
SELECT * 
FROM country
WHERE Population >= 50000000;

SELECT * FROM large_country;

SELECT *
FROM large_country;

-- country_view 생성
CREATE VIEW country_view AS
SELECT
	co.Name co_name,
    ci.Name ci_name
FROM country co INNER JOIN city ci
	ON co.code = ci.countrycode;
    
SELECT * FROM country_view;

-- DB에 있는 모든 테이블(뷰 포함)
SHOW FULL TABLES;
-- 모든 VIEW 출력
SHOW FULL TABLES WHERE Table_type = 'VIEW';
DROP VIEW large_country;