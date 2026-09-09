SET SERVEROUTPUT ON;

-- ============================================================
-- P1.11 - Date Function Playground
--
-- Question:
-- Write a PL/SQL block that prints:
--
-- 1. Today's date using TO_CHAR().
-- 2. Date after N months using ADD_MONTHS().
-- 3. Last day of the current month using LAST_DAY().
-- 4. Date of the next Monday using NEXT_DAY().
-- 5. Number of days left in the current month.
--
-- Required date format:
--     Day, DDth Month YYYY
--
-- Key points:
-- 1. SYSDATE returns the current database date.
-- 2. TO_CHAR() formats a DATE value for display.
-- 3. ADD_MONTHS() adds a specified number of months.
-- 4. LAST_DAY() returns the last date of a month.
-- 5. NEXT_DAY() returns the next occurrence of a weekday.
-- 6. Subtracting two DATE values gives the difference in days.
-- 7. TRUNC() removes the decimal part from the number of days.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Assignment formula:
-- N = roll_no MOD 12 + 1
-- N = 50 MOD 12 + 1
-- N = 9 + 1
-- N = 10 months
-- ============================================================

DECLARE
    v_n NUMBER;
    
    v_today        DATE;
    v_after_months DATE;
    v_last_day     DATE;
    v_next_monday  DATE;
    v_days_left    NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Generate N using the assignment's roll-number formula.
    -- --------------------------------------------------------

    v_n := MOD(50, 12) + 1;


    -- --------------------------------------------------------
    -- Store the required date values.
    -- --------------------------------------------------------

    v_today := SYSDATE;

    v_after_months := ADD_MONTHS(v_today, v_n);

    v_last_day := LAST_DAY(v_today);

    v_next_monday := NEXT_DAY(v_today, 'MONDAY');

    -- Subtracting two DATE values gives the number of days.
    -- TRUNC removes any time/fractional part.
    v_days_left := TRUNC(v_last_day - v_today);


    -- --------------------------------------------------------
    -- Display results.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          DATE FUNCTION PLAYGROUND');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name       : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No    : 50'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Months (N) : ' || v_n
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Today          : ' ||
        TO_CHAR(v_today, 'Day, DDth Month YYYY')
    );

    DBMS_OUTPUT.PUT_LINE(
        'After ' || v_n || ' Months : ' ||
        TO_CHAR(v_after_months, 'DD-MON-YYYY')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Last Day       : ' ||
        TO_CHAR(v_last_day, 'DD-MON-YYYY')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Next Monday    : ' ||
        TO_CHAR(v_next_monday, 'DD-MON-YYYY')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Days Left      : ' || v_days_left || ' days'
    );

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/