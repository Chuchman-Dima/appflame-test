-- Task 1:
-- Скласти рейтинг працівників за розміром заробітної плати.
-- Розрахувати кумулятивну суму за цим
WITH table_rank_salary AS(
    SELECT
       id, name, department, salary
       , ROW_NUMBER() OVER(ORDER BY salary ASC) AS rank_person_salary
    FROM employees
)
SELECT
    id, name, department, salary, rank_person_salary
    , SUM(salary) OVER(ORDER BY rank_person_salary DESC) AS cum_sum
FROM table_rank_salary
ORDER BY rank_person_salary DESC;


-- Task 2:
-- Той самий рейтинг, тільки не для всієї компанії, а по кожному департаменту
SELECT
    id, name, department, salary
    , ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_number_
FROM employees
ORDER BY department, row_number_;

-- Task 3:
-- Упорядкувати працівників щодо зростання зарплати та перевірити,
-- чи великий розрив між сусідами у відсотках
SELECT
    id, name, department, salary
    , ROUND((salary - LAG(salary) OVER(ORDER BY salary))*100.0
    / LAG(salary) OVER(ORDER BY salary),1) AS diff_from_prev
FROM employees
ORDER BY salary;

-- Task 4:
SELECT
    id, name, department, salary
    , ROUND(salary*100.0 / (SUM(salary) OVER(PARTITION BY department)),1) AS fund_share
FROM employees
ORDER BY department;