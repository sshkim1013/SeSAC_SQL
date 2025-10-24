-- 데이터베이스 생성 
CREATE DATABASE temp
CHARACTER SET utf8mb4;

-- 데이터베이스 삭제
DROP DATABASE temp;

-- 데이터베이스 목록 조회 
SHOW DATABASES;

-- 데이터베이스 사용
USE temp;

-- 테이블 생성
CREATE TABLE customer (
	id 		INT				PRIMARY KEY AUTO_INCREMENT,
    name	VARCHAR(50)		NOT NULL,
    email	VARCHAR(100)	NOT NULL
);

-- CRUD
INSERT INTO customer (name, email) VALUES 
('Kim', 'ksh99@abc.com'),
('Lee', '1234@gmail.com'),
('Hong', 'qwer@nate.com');
SELECT * FROM customer;
UPDATE customer SET email = '1234@naver.com', name='Choi' WHERE id = 3;
DELETE FROM customer WHERE id = 1;

-- SELECT
SELECT name, email AS 이메일 FROM customer;

UPDATE customer SET email='123@gmail.com' WHERE id=10;

USE world;
SELECT DISTINCT continent FROM country;