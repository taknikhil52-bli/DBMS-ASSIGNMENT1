SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.21 - Salary Slip Generator with %ROWTYPE
--
-- Question:
-- Generate a monthly salary slip.
--
-- Requirements:
-- 1. Fetch the complete employee row into:
--       v_emp employees%ROWTYPE
--
-- 2. Employee ID:
--       100 + (roll_no MOD 20)
--
-- 3. Calculate:
--       DA  = 40% of salary
--       HRA = 20% of salary
--       PF  = 12% of salary
--
-- 4. Net Pay:
--       Salary + DA + HRA - PF
--
-- 5. Print a professional salary slip containing:
--       Company name
--       Month and Year
--       Employee name
--       Employee ID
--       Job
--       Basic Salary
--       DA
--       HRA
--       PF Deduction
--       Net Pay
--
-- 6. Use TO_CHAR() for amount formatting.
-- 7. Use LPAD/RPAD so all amounts line up in one column.
--
-- Key points:
-- 1. %ROWTYPE stores the complete row structure.
-- 2. SELECT * INTO fetches the employee row.
-- 3. Arithmetic operators are used for salary calculations.
-- 4. LPAD aligns monetary values to the right.
-- 5. RPAD aligns labels to the left.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Employee ID:
-- 100 + (33 MOD 20)
-- = 100 + 13
-- = 113
-- ============================================================


-- ============================================================
-- DATABASE SETUP
--
-- The EMPLOYEES table was already created in previous
-- practicals, so it is NOT dropped or recreated here.
--
-- P1.21 requires employee 113.
--
-- MERGE is used so that employee 113 is inserted only if
-- the record does not already exist.
--
-- This prevents duplicate rows when the file is run again.
-- ============================================================

MERGE INTO employees e
USING (
    SELECT
        113 AS employee_id,
        'Luis' AS first_name,
        'PU_CLERK' AS job_id,
        30 AS department_id,
        6900 AS salary,
        DATE '2007-12-07' AS hire_date
    FROM dual
) s
ON (e.employee_id = s.employee_id)

WHEN NOT MATCHED THEN
    INSERT (
        employee_id,
        first_name,
        job_id,
        department_id,
        salary,
        hire_date
    )
    VALUES (
        s.employee_id,
        s.first_name,
        s.job_id,
        s.department_id,
        s.salary,
        s.hire_date
    );

COMMIT;


-- ============================================================
-- PRACTICAL PROGRAM
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- %ROWTYPE creates a record containing every column of
    -- the EMPLOYEES table.
    -- --------------------------------------------------------

    v_emp employees%ROWTYPE;

    v_id employees.employee_id%TYPE;

    -- Salary components.
    v_da  NUMBER;
    v_hra NUMBER;
    v_pf  NUMBER;

    v_net NUMBER;

BEGIN

    -- --------------------------------------------------------
    -- Calculate employee ID using the assignment formula.
    --
    -- 100 + (50 MOD 20)
    -- = 113
    -- --------------------------------------------------------

    v_id := 100 + MOD(50, 20);


    -- --------------------------------------------------------
    -- Fetch the complete employee row.
    -- --------------------------------------------------------

    SELECT *
    INTO v_emp
    FROM employees
    WHERE employee_id = v_id;


    -- --------------------------------------------------------
    -- Calculate salary components.
    --
    -- DA  = 40% of Basic Salary
    -- HRA = 20% of Basic Salary
    -- PF  = 12% of Basic Salary
    -- --------------------------------------------------------

    v_da := v_emp.salary * 0.40;

    v_hra := v_emp.salary * 0.20;

    v_pf := v_emp.salary * 0.12;


    -- --------------------------------------------------------
    -- Calculate Net Pay.
    --
    -- Net Pay = Salary + DA + HRA - PF
    -- --------------------------------------------------------

    v_net :=
        v_emp.salary
        + v_da
        + v_hra
        - v_pf;


    -- ========================================================
    -- SALARY SLIP OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('              LJ UNIVERSITY', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('               SALARY SLIP', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD(
            'Month: ' ||
            TO_CHAR(SYSDATE, 'Month YYYY'),
            48
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );


    -- --------------------------------------------------------
    -- Employee information
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Employee Name', 22) ||
        ': ' ||
        RPAD(v_emp.first_name, 24) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Employee ID', 22) ||
        ': ' ||
        RPAD(v_emp.employee_id, 24) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Job', 22) ||
        ': ' ||
        RPAD(v_emp.job_id, 24) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );


    -- ========================================================
    -- EARNINGS
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('EARNINGS', 48) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Basic Salary', 27) ||
        LPAD(
            TO_CHAR(v_emp.salary, 'FM99,99,999.00'),
            20
        ) ||
        ' |'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('DA (40%)', 27) ||
        LPAD(
            TO_CHAR(v_da, 'FM99,99,999.00'),
            20
        ) ||
        ' |'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('HRA (20%)', 27) ||
        LPAD(
            TO_CHAR(v_hra, 'FM99,99,999.00'),
            20
        ) ||
        ' |'
    );


    -- ========================================================
    -- DEDUCTIONS
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('DEDUCTIONS', 48) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('PF Deduction (12%)', 27) ||
        LPAD(
            TO_CHAR(v_pf, 'FM99,99,999.00'),
            20
        ) ||
        ' |'
    );


    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );


    -- ========================================================
    -- NET PAY
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('NET PAY', 27) ||
        LPAD(
            'Rs.' ||
            TO_CHAR(v_net, 'FM99,99,999.00'),
            20
        ) ||
        ' |'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );


EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'Employee not found - check the employee ID.'
        );

END;
/