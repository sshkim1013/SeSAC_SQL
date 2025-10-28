USE temp;

CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(10),
	balance INT
);

-- 100,000원을 가지고 있는 유저 Kim 데이터 삽입
INSERT INTO accounts(name, balance) 
VALUES('Kim', 100000);

-- 200,000원을 가지고 있는 유저 Lee 데이터 삽입
INSERT INTO accounts(name, balance)
VALUES('Lim', 200000);

SELECT * FROM accounts;

-- 유저들끼리의 입출금 처리
-- 두 쿼리는 하나로 묶여 움직여야 한다.
START TRANSACTION;	-- 이 시점부터 실행하는 모든 로직은 트랜잭션으로 실행된다.
UPDATE accounts SET balance = balance+10000 WHERE id = 1;
UPDATE accounts SET balance = balance-10000 WHERE id = 2;
COMMIT;	-- 트랜잭션 결과를 DB에 반환.
ROLLBACK;	-- COMMIT 하기 이전의 상태로 돌아감.


-- 아래는 SAVEPOINT 예제
START TRANSACTION;

INSERT INTO accounts(name, balance) 
VALUES ('hong', 0);

SAVEPOINT sp1;

INSERT INTO accounts(name, balance)
VALUES ('choi', 999999);

SAVEPOINT sp2;

ROLLBACK TO SAVEPOINT sp1;
COMMIT;

SELECT * FROM accounts;


-- 아래는 @@autocommit 예제 
SELECT * FROM accounts;

-- 실행할 때마다 아래 유저는 계속 추가된다.
INSERT INTO accounts(name, balance) VALUES('choi', 0);

-- @@autocommit = 1 : 내부적으로 커밋을 자동으로 해줌, 다른 스키마에서 SELECT(조회) 시 업데이트 되어 있음.
-- @@autocommit = 0 : 내부적으로 커밋을 하지 않음, 다른 스키마에서 SELECT(조회) 시 업데이트 되어 있지 않음.
SET @@autocommit = 0;

-- @@autocommit 여부 확인용 쿼리
SELECT @@autocommit;