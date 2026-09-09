SET SERVEROUTPUT ON;

-- ============================================================
-- P1.16 - Department Lookup with %TYPE
--
-- Question:
-- Declare:
--
--   v_dname departments.department_name%TYPE
--   v_loc   departments.location_id%TYPE
--
-- Fetch the department name and location for a seeded
-- department_id using SELECT INTO.
--
-- Display:
--   Dept [id]: [name] at location [loc]
--
-- Handle NO_DATA_FOUND.
--
-- Also explain:
-- If the DBA changes department_name from VARCHAR2(30)
-- to VARCHAR2(60), why does the block still work without
-- any edit?
--
-- Key points:
-- 1. %TYPE anchors a variable's datatype to a table column.
-- 2. SELECT INTO stores query results in PL/SQL variables.
-- 3. NO_DATA_FOUND occurs when SELECT INTO finds no row.
-- 4. %TYPE reduces datatype dependency in PL/SQL programs.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Department ID formula:
-- ((roll_no + 2) MOD 11 + 1) * 10
--
-- ((50 + 2) MOD 11 + 1) * 10
-- = (35 MOD 11 + 1) * 10
-- = (2 + 1) * 10
-- = 30
--
-- NOTE:
-- EMPLOYEES is NOT used here because this question requires
-- department_name and location_id.
-- A separate table named DEPARTMENTS_P116 is used so that
-- existing tables are not modified.
-- ============================================================


-- ============================================================
-- DATABASE SETUP
--
-- Create a separate table specifically for P1.16.
--
-- The table name is different from the standard DEPARTMENTS
-- name to avoid conflicts with an existing Oracle schema.
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE departments_p116 CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        -- ORA-00942 means the table does not exist.
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

CREATE TABLE departments_p116 (
    department_id   NUMBER(4) PRIMARY KEY,
    department_name VARCHAR2(30),
    location_id     NUMBER(4)
);


-- ============================================================
-- SAMPLE DATA
-- ============================================================

INSERT INTO departments_p116
VALUES (10, 'Administration', 1700);

INSERT INTO departments_p116
VALUES (20, 'Marketing', 1800);

INSERT INTO departments_p116
VALUES (30, 'Purchasing', 1700);

INSERT INTO departments_p116
VALUES (40, 'Human Resources', 2400);

INSERT INTO departments_p116
VALUES (50, 'Shipping', 1500);

INSERT INTO departments_p116
VALUES (60, 'IT', 1400);

INSERT INTO departments_p116
VALUES (70, 'Public Relations', 2700);

INSERT INTO departments_p116
VALUES (80, 'Sales', 2500);

COMMIT;


-- ============================================================
-- PRACTICAL PROGRAM
-- ============================================================

DECLARE

    -- %TYPE takes the datatype from the corresponding column.
    v_dname departments_p116.department_name%TYPE;

    v_loc departments_p116.location_id%TYPE;

    v_id departments_p116.department_id%TYPE;

BEGIN

    -- --------------------------------------------------------
    -- Calculate department ID using the assignment formula.
    -- --------------------------------------------------------

    v_id := (MOD(50 + 2, 11) + 1) * 10;


    -- --------------------------------------------------------
    -- Fetch department name and location using SELECT INTO.
    -- --------------------------------------------------------

    SELECT department_name,
           location_id
    INTO v_dname,
         v_loc
    FROM departments_p116
    WHERE department_id = v_id;


    -- --------------------------------------------------------
    -- Display department information.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('         DEPARTMENT LOOKUP');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name     : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No  : 50'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Dept ' || v_id ||
        ': ' || v_dname ||
        ' at location ' || v_loc
    );

    DBMS_OUTPUT.PUT_LINE('========================================');


EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'Department not found - check the department ID.'
        );

END;
/