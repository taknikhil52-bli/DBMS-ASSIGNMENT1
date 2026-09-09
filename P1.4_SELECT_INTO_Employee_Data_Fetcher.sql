SET SERVEROUTPUT ON;

-- ============================================================
-- P1.4 - SELECT INTO - Employee Data Fetcher
--
-- Question:
-- Declare v_fname using employees.first_name%TYPE and
-- v_sal using employees.salary%TYPE.
--
-- Fetch first_name and salary of a specific employee using
-- SELECT INTO.
--
-- Display:
-- Employee: [name] earns Rs.[salary] per month.
--
-- Handle NO_DATA_FOUND and display:
-- Employee not found - check the ID.
--
-- Test:
-- 1. A valid employee ID
-- 2. A non-existent employee ID
--
-- Key points:
-- 1. SELECT INTO stores query results into PL/SQL variables.
-- 2. %TYPE takes the datatype from a table column.
-- 3. SELECT INTO should return one row.
-- 4. NO_DATA_FOUND occurs when no row is found.
-- 5. Required employee ID:
--       100 + (roll_no MOD 7)
--
-- ============================================================


-- ============================================================
-- DATABASE SETUP
--
-- The assignment requires an EMPLOYEES table containing:
-- employee_id, first_name and salary.
--
-- The DROP statement below prevents a previously created
-- EMPLOYEES table with a different structure from causing
-- compilation errors.
--
-- This file is intended for the assignment practice database.
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        -- ORA-00942 means the table does not exist.
        -- In that case there is nothing to remove.
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Create the EMPLOYEES table required for this practical.

CREATE TABLE employees (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name  VARCHAR2(50),
    salary      NUMBER(10,2)
);


-- ============================================================
-- SAMPLE DATA
-- ============================================================

INSERT INTO employees VALUES (101, 'Steven', 17000);
INSERT INTO employees VALUES (102, 'Lex', 15000);
INSERT INTO employees VALUES (103, 'Alexander', 9000);
INSERT INTO employees VALUES (104, 'Bruce', 6000);
INSERT INTO employees VALUES (105, 'David', 4800);
INSERT INTO employees VALUES (106, 'Valli', 4800);
INSERT INTO employees VALUES (107, 'Diana', 4200);

COMMIT;


-- ============================================================
-- PRACTICAL PROGRAM
-- ============================================================

DECLARE
    -- %TYPE takes the datatype directly from the table column.
    v_fname employees.first_name%TYPE;
    v_sal   employees.salary%TYPE;

    v_id employees.employee_id%TYPE;
BEGIN

    -- ========================================================
    -- TEST 1: VALID EMPLOYEE ID
    --
    -- Roll No = 50
    -- 50 MOD 7 = 5
    -- Employee ID = 100 + 5 = 105
    -- ========================================================

    v_id := 100 + MOD(33, 7);

    BEGIN
        -- SELECT INTO fetches the employee's name and salary.
        SELECT first_name, salary
        INTO v_fname, v_sal
        FROM employees
        WHERE employee_id = v_id;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('VALID EMPLOYEE SEARCH');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');

        DBMS_OUTPUT.PUT_LINE(
            'Employee: ' || v_fname ||
            ' earns Rs.' || TO_CHAR(v_sal, '99,999.00') ||
            ' per month.'
        );

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(
                'Employee not found - check the ID.'
            );
    END;


    -- ========================================================
    -- TEST 2: NON-EXISTENT EMPLOYEE ID
    --
    -- Roll No 50 itself is used as the employee ID.
    -- No employee with ID 33 exists in our sample data.
    --
    -- This demonstrates the NO_DATA_FOUND exception.
    -- ========================================================

    v_id := 33;

    BEGIN
        SELECT first_name, salary
        INTO v_fname, v_sal
        FROM employees
        WHERE employee_id = v_id;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
        DBMS_OUTPUT.PUT_LINE('SECOND EMPLOYEE SEARCH');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');

        DBMS_OUTPUT.PUT_LINE(
            'Employee: ' || v_fname ||
            ' earns Rs.' || TO_CHAR(v_sal, '99,999.00') ||
            ' per month.'
        );

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(
                'Employee not found - check the ID.'
            );
    END;

END;
/