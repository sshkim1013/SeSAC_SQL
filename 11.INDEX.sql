USE world;

SHOW INDEX FROM city;

DESCRIBE city;

-- city의 name 컬럼을 인덱스로 만드는 문법
CREATE INDEX idx_city_name ON city(Name);
EXPLAIN SELECT * FROM city WHERE Name = 'Seoul';

-- 인덱스 삭제
DROP INDEX idx_city_name ON city;