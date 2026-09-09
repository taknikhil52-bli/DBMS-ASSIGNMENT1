SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.23 - Debug Challenge - Fix the Broken Block
--
-- Question:
-- A junior developer wrote a PL/SQL block containing exactly
-- 5 bugs. Find and fix all five bugs.
--
-- Original broken block:
--
-- DECLARE
--     v_name VARCHAR2(5) = 'Your Full Name';
--     v_bonus CONSTANT NUMBER;
--     v_sal NUMBER := 25000
-- BEGIN
--     v_bonus := v_sal * 0.1;
--     SELECT first_name FROM employees WHERE employee_id = 100;
--     DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus)
-- END;
--
-- Five bugs to identify:
--
-- 1. "=" used instead of ":=" for variable initialization.
-- 2. VARCHAR2(5) is too small for the full name.
-- 3. CONSTANT declared without an initial value and then
--    assigned later.
-- 4. Missing semicolon after the v_sal declaration.
-- 5. SELECT inside PL/SQL requires an INTO clause.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Salary formula:
-- v_sal = roll_no * 1000 + 20000
--       = 33 * 1000 + 20000
--       = Rs.53,000
--
-- Bonus:
-- 10% of Rs.53,000 = Rs.5,300
--
-- The existing EMPLOYEES table is used only to demonstrate
-- the SELECT INTO correction.
-- ============================================================


DECLARE

    -- --------------------------------------------------------
    -- BUG 1:
    -- Original:
    -- v_name VARCHAR2(5) = 'Your Full Name';
    --
    -- ERROR:
    -- "=" cannot be used for PL/SQL variable initialization.
    --
    -- FIX:
    -- Use ":=".
    -- --------------------------------------------------------

    -- BUG 2:
    -- VARCHAR2(5) is too small for "Nirav Vala".
    --
    -- FIX:
    -- Increase the size to VARCHAR2(50).
    --
    v_name VARCHAR2(50) := 'Nikhil tak';


    -- --------------------------------------------------------
    -- BUG 3:
    -- A CONSTANT must receive a value when declared.
    --
    -- Original:
    -- v_bonus CONSTANT NUMBER;
    --
    -- It cannot be assigned later.
    --
    -- FIX:
    -- Store the bonus rate as a constant.
    -- --------------------------------------------------------

    c_bonus_rate CONSTANT NUMBER := 0.10;


    -- --------------------------------------------------------
    -- BUG 4:
    -- Original:
    -- v_sal NUMBER := 25000
    --
    -- ERROR:
    -- Missing semicolon after the declaration.
    --
    -- FIX:
    -- Add ";".
    --
    -- Personalised salary:
    -- 33 * 1000 + 20000 = 53000
    -- --------------------------------------------------------

    v_sal NUMBER := 33 * 1000 + 20000;


    -- Bonus calculated from salary.
    v_bonus NUMBER;


    -- --------------------------------------------------------
    -- BUG 5:
    -- SELECT statements inside PL/SQL require an INTO clause
    -- when retrieving a value.
    --
    -- We therefore store first_name in v_fname.
    -- --------------------------------------------------------

    v_fname employees.first_name%TYPE;

BEGIN

    -- --------------------------------------------------------
    -- Calculate the bonus.
    -- --------------------------------------------------------

    v_bonus := v_sal * c_bonus_rate;


    -- --------------------------------------------------------
    -- Corrected SELECT statement.
    --
    -- Original:
    -- SELECT first_name
    -- FROM employees
    -- WHERE employee_id = 100;
    --
    -- Correct:
    -- SELECT first_name INTO v_fname
    -- FROM employees
    -- WHERE employee_id = 100;
    --
    -- The SELECT is included to demonstrate the correction
    -- required by the assignment.
    -- --------------------------------------------------------

    BEGIN

        SELECT first_name
        INTO v_fname
        FROM employees
        WHERE employee_id = 100;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            -- Our local sample EMPLOYEES table may not contain
            -- employee 100. The bonus calculation does not
            -- depend on this employee lookup.
            v_fname := 'Employee not found';

    END;


    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '       DEBUG CHALLENGE - FIXED'
    );

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Name          : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Salary        : Rs.' ||
        TO_CHAR(v_sal, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Bonus Rate    : 10%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Bonus         : Rs.' ||
        TO_CHAR(v_bonus, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Employee 100  : ' || v_fname
    );

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );

END;
/