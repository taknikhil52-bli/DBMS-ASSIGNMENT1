SET SERVEROUTPUT ON;

-- ============================================================
-- P1.5 - %ROWTYPE - Employee Profile Card
--
-- Question:
-- Declare v_emp using employees%ROWTYPE.
-- Fetch the complete employee row for:
--
--     employee_id = 100 + (roll_no MOD 9) + 1
--
-- Display:
-- 1. Employee Name
-- 2. Job ID
-- 3. Department ID
-- 4. Salary formatted as Rs.XX,XXX
-- 5. Hire Date as DD-MON-YYYY
-- 6. Years of Experience
--
-- If experience is greater than 10 years, print:
--     Senior Employee
--
-- Key points:
-- 1. %ROWTYPE creates one record containing all columns
--    of the EMPLOYEES table.
-- 2. SELECT * INTO fetches the complete employee row.
-- 3. MONTHS_BETWEEN calculates the difference between dates.
-- 4. Divide the result by 12 to convert months into years.
-- 5. TRUNC removes the decimal part of the experience.
-- 6. TO_CHAR formats numbers and dates for display.
--
-- NOTE:
-- The EMPLOYEES table was already created in the previous
-- practical and already contains the required columns.
-- Therefore, it is NOT created or inserted again here.
-- ============================================================

DECLARE
    -- %ROWTYPE takes the complete structure of EMPLOYEES.
    v_emp employees%ROWTYPE;

    -- Store the employee ID selected using the roll number.
    v_id employees.employee_id%TYPE;

    -- Store calculated years of experience.
    v_yrs NUMBER;

BEGIN

    -- --------------------------------------------------------
    -- Calculate employee ID using the assignment formula.
    --
    -- 50 MOD 9 = 6
    -- 100 + 6 + 1 = 107
    -- --------------------------------------------------------

    v_id := 100 + MOD(33, 9) + 1;


    -- --------------------------------------------------------
    -- Fetch the complete employee row.
    -- --------------------------------------------------------

    SELECT *
    INTO v_emp
    FROM employees
    WHERE employee_id = v_id;


    -- --------------------------------------------------------
    -- Calculate years of experience.
    --
    -- MONTHS_BETWEEN gives the difference in months.
    -- / 12 converts months into years.
    -- TRUNC removes the decimal part.
    -- --------------------------------------------------------

    v_yrs := TRUNC(
        MONTHS_BETWEEN(SYSDATE, v_emp.hire_date) / 12
    );


    -- --------------------------------------------------------
    -- Display employee profile card.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          EMPLOYEE PROFILE CARD');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Employee ID        : ' || v_emp.employee_id
    );

    DBMS_OUTPUT.PUT_LINE(
        'Name               : ' || v_emp.first_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Job ID             : ' || v_emp.job_id
    );

    DBMS_OUTPUT.PUT_LINE(
        'Department ID      : ' || v_emp.department_id
    );

    -- FM removes unnecessary leading spaces.
    -- Rs. is kept outside the number format model.
    DBMS_OUTPUT.PUT_LINE(
        'Salary             : Rs.' ||
        TO_CHAR(v_emp.salary, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Hire Date          : ' ||
        TO_CHAR(v_emp.hire_date, 'DD-MON-YYYY')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Years of Experience: ' || v_yrs || ' years'
    );


    -- --------------------------------------------------------
    -- If experience is more than 10 years, classify the
    -- employee as a Senior Employee.
    -- --------------------------------------------------------

    IF v_yrs > 10 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Status             : Senior Employee'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('========================================');


EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'Employee not found - check the employee ID.'
        );

END;
/

s