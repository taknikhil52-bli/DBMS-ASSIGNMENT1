SET SERVEROUTPUT ON;

-- ============================================================
-- P1.15 - Department Statistics with SELECT INTO
--
-- Question:
-- For a given department_id, use ONE SELECT INTO query to
-- fetch:
--
--   1. COUNT(*)
--   2. ROUND(AVG(salary), 2)
--   3. MAX(salary)
--
-- Store the values in three variables and print a department
-- summary.
--
-- Also answer:
-- Why does SELECT INTO with COUNT(*) never raise
-- NO_DATA_FOUND even when the department has no employees?
--
-- Key points:
-- 1. Aggregate functions can be used with SELECT INTO.
-- 2. COUNT(*) always returns one row.
-- 3. AVG() returns NULL when there are no matching employees.
-- 4. MAX() returns NULL when there are no matching employees.
-- 5. ROUND(AVG(salary), 2) keeps the average salary to
--    two decimal places.
-- 6. The assignment requires all three aggregate values in
--    ONE SELECT INTO statement.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Department ID formula:
-- (roll_no MOD 6 + 1) * 10
--
-- (50 MOD 6 + 1) * 10
-- = (3 + 1) * 10
-- = 40
--
-- NOTE:
-- The existing EMPLOYEES table is used.
-- It already contains the required department_id and salary
-- columns, so no table is created again.
-- ============================================================

DECLARE
    v_dept_id  employees.department_id%TYPE;

    v_count    NUMBER;
    v_avg      NUMBER;
    v_max      NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Calculate the department ID using the assignment's
    -- roll-number formula.
    -- --------------------------------------------------------

    v_dept_id := (MOD(33, 6) + 1) * 10;


    -- --------------------------------------------------------
    -- Fetch all three aggregate values using ONE SELECT INTO.
    --
    -- COUNT(*) always returns one row, even when no employee
    -- belongs to the selected department.
    --
    -- AVG() and MAX() become NULL when there are no employees.
    -- --------------------------------------------------------

    SELECT COUNT(*),
           ROUND(AVG(salary), 2),
           MAX(salary)
    INTO v_count,
         v_avg,
         v_max
    FROM employees
    WHERE department_id = v_dept_id;


    -- --------------------------------------------------------
    -- Display department summary.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('       DEPARTMENT STATISTICS');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name         : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No      : 50'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department ID: ' || v_dept_id
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Employee Count : ' || v_count
    );

    -- AVG is NULL when the department has no employees.
    IF v_avg IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(
            'Average Salary : No employees'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Average Salary : Rs.' ||
            TO_CHAR(v_avg, 'FM99,999.00')
        );
    END IF;


    -- MAX is NULL when the department has no employees.
    IF v_max IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(
            'Maximum Salary : No employees'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Maximum Salary : Rs.' ||
            TO_CHAR(v_max, 'FM99,999.00')
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('========================================');


    -- ========================================================
    -- ANSWER:
    --
    -- COUNT(*) is an aggregate function.
    --
    -- Even if no employee matches the WHERE condition,
    -- COUNT(*) returns a result of 0.
    --
    -- Therefore SELECT INTO still receives one row:
    --
    -- COUNT(*) = 0
    --
    -- and NO_DATA_FOUND is NOT raised.
    --
    -- In contrast, AVG() and MAX() return NULL when there
    -- are no matching rows.
    -- ========================================================

END;
/