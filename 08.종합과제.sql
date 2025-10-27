USE temp;
SELECT * FROM titanic;

-- 1. 데이터 기본 탐색
-- 타이타닉 테이블에서 모든 컬럼의 상위 5개 행을 조회하세요.
SELECT *
FROM titanic
LIMIT 5;

-- 타이타닉 테이블의 전체 승객 수를 조회하세요. (결과 컬럼명: row_count)
SELECT COUNT(*) row_count
FROM titanic;

-- cabin 컬럼의 결측치(빈 문자열) 개수를 조회하세요.
SELECT SUM(
        CASE 
		  WHEN cabin = '' THEN 1 
		  ELSE 0
        END) AS "결측치 개수"
FROM titanic;


-- 요금(fare)의 최솟값, 최댓값, 평균값을 조회하세요.
SELECT
	MIN(Fare),
	MAX(Fare),
    ROUND(AVG(Fare), 2)
FROM titanic;

-- 2. 기본 조회 (필터링 & 정렬)
-- 1등석(pclass=1) 승객의 이름(name), 티켓(ticket), 요금(fare)를 조회하세요.
SELECT
	name,
    ticket,
    fare
FROM titanic
WHERE pclass = 1;

-- 셰르부르 항구(embarked = 'C')에서 탑승한 승객의 모든 정보를 조회하세요.
SELECT *
FROM titanic
WHERE embarked = 'C';

-- 30세 미만이면서 생존한 승객의 이름(name), 나이(age), 성별(sex)을 조회하세요.
SELECT
	name,
    age,
    sex
FROM titanic
WHERE age < 30 AND survived = 1;

-- 모든 승객을 요금이 비싼 순서로 정렬하여 조회하세요.
SELECT
	name,
    pclass,
    fare
FROM titanic
ORDER BY fare DESC;

-- 1등석 여성 승객의 이름(name), 나이(age), 요금(fare)을 조회하세요.
SELECT
	name,
    age,
    fare
FROM titanic
WHERE pclass = 1 AND sex = 'female'
ORDER BY age;

-- 3. 데이터 집계 (Aggregation & Grouping)
-- 전체 생존율 (소수점 둘째 자리까지 백분율로 표시)
SELECT ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic;

-- 생존 여부별 승객 수
SELECT 
	survived "생존 여부",
	COUNT(*)
FROM titanic
GROUP BY survived;

-- 성별로 다음 정보를 조회하세요:
-- - 총 승객 수
-- - 생존자 수
-- - 생존율 (소수점 둘째 자리까지 백분율)
-- - 생존율이 높은 순서로 정렬
SELECT
	sex,
	COUNT(*) "총 승객 수",
    SUM(survived) "생존자 수",
    ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY sex
ORDER BY 생존율 DESC;

-- 다음 두 가지 정보를 각각 조회하세요:
-- - 등급별 생존율
SELECT 
	pclass "등급",
	AVG(survived) * 100 "생존율"
FROM titanic
GROUP BY pclass
ORDER BY pclass;

-- - 등급별 평균 요금, 최소 요금, 최대 요금
SELECT 
	pclass,
	ROUND(AVG(fare), 2) "평균 요금",
    MIN(fare) "최소 요금",
    MAX(fare) "최대 요금"
FROM titanic
GROUP BY pclass
ORDER BY pclass;

-- 탑승 항구와 등급별로 승객 수를 조회하세요.
-- - embarked가 빈 문자열인 데이터는 제외
-- - 항구, 등급 순서로 정렬
SELECT 
	embarked,
    pclass,
	COUNT(*)
FROM titanic
WHERE embarked != ""
GROUP BY embarked, pclass
ORDER BY embarked, pclass;

SELECT embarked
FROM titanic;

-- 등급과 성별로 다음 정보를 조회하세요:
-- - 총 승객 수
-- - 생존자 수
-- - 생존율(백분율)
-- - 등급, 성별 순서로 정렬
SELECT 
	pclass,
    sex,
	COUNT(*) "총 승객 수",
    SUM(survived) "생존자 수",
    ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY pclass, sex
ORDER BY 1, 2;

-- 다음 두 가지 정보를 각각 조회하세요:
-- - 1) '혼자' vs '가족 동반' 생존율 비교
-- - 가족 규모 = sibsp + parch
-- - 0명이면 '혼자', 1명 이상이면 '가족동반'
SELECT 
	(CASE 
	  WHEN sibsp + parch >= 1 THEN '가족 동반'
      ELSE '혼자'
    END) 동반유형,
	ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY (CASE
			WHEN sibsp + parch >= 1 THEN '가족 동반'
            ELSE '혼자'
		  END);
          
-- 2) 가족이 1명이라도 있는 승객의 평균 생존율
SELECT ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
WHERE sibsp >= 1 OR parch >= 1;

-- 가족 규모(본인 포함 = 1 + sibsp + parch)별로 승객 수와 생존율을 조회하세요.
-- - 가족 규모 순서로 정렬
SELECT 1 + sibsp + parch 가족규모,
	   COUNT(*) 승객수,
       ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY 1 + sibsp + parch
ORDER BY 가족규모;

-- 4. 고급 분석 (CASE & HAVING & 서브쿼리)
-- 다음 방식으로 연령대를 구분하여 생존율을 조회하세요:
-- - 18세 미만 → 'Child'
-- - 18-60세 → 'Adult'
-- - 60세 초과 → 'Senior'
SELECT (CASE 
		  WHEN age < 18 THEN 'Child'
		  WHEN age BETWEEN 18 AND 60 THEN 'Adult'
		  ELSE 'Senior'
	    END) "연령대",
	   ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY (CASE 
			WHEN age < 18 THEN 'Child'
            WHEN age BETWEEN 18 AND 60 THEN 'Adult'
            ELSE 'Senior'
		  END);

-- 요금을 다음 구간으로 분류하고 생존율을 조회하세요:
-- - 10달러 미만 → '저가(<10)'
-- - 10-30달러 → '중저가(10-29)'
-- - 30-100달러 → '중고가(30-99)'
-- - 100달러 이상 → '고가(100+)'
-- - 요금 구간 순서로 정렬
SELECT
	CASE
		WHEN fare < 10 THEN '저가'
    WHEN fare < 30 THEN '중저가'
    WHEN fare < 100 THEN '중고가'
    ELSE '고가'
  END AS 요금분류,
  ROUND(AVG(survived) * 100, 2) 생존율
FROM titanic
GROUP BY 요금분류
ORDER BY
	CASE 요금분류
		WHEN '저가' THEN 1
        WHEN '중저가' THEN 2
        WHEN '중고가' THEN 3
        ELSE 4
    END;


-- 등급별로 평균 요금을 계산하되, 평균 요금이 50달러를 초과하는 등급만 조회하세요.
SELECT 
	pclass 등급,
	ROUND(AVG(fare), 2) 평균요금
FROM titanic
GROUP BY pclass
HAVING AVG(fare) >= 50;

-- 전체 평균 요금보다 많이 지불한 승객을 조회하세요.
-- - 이름(name), 등급(pclass), 요금(fare), 전체 평균 요금 표시
-- - 요금이 높은 순서로 정렬
-- - 상위 20명만 조회
SELECT 
	name 이름,
    pclass 등급,
    fare 요금
FROM titanic
WHERE fare > (
		SELECT AVG(fare)
		FROM titanic)
ORDER BY 3 DESC
LIMIT 20;

-- 1등석 승객 중 3등석 평균 나이보다 나이가 많은 승객을 조회하세요.
-- - 이름(name), 나이(age), 등급(pclass), 3등석 평균 나이 표시
-- - 나이가 많은 순서로 정렬
-- - 상위 20명만 조회
SELECT
	name 이름,
    age 나이,
    pclass
FROM titanic
WHERE pclass = 1 AND age > (SELECT AVG(age) FROM titanic WHERE pclass = 3)
ORDER BY age DESC
LIMIT 20;
