SET SERVEROUTPUT ON;

-- ============================================================
-- P1.2 - Variables and Data Types
--
-- Question:
-- Declare the following variables:
--   v_name       VARCHAR2(50)
--   v_marks      NUMBER(5,2)
--   v_percentage NUMBER(5,2)
--   v_dob        DATE
--   v_passed     BOOLEAN
--
-- Use your own name and last semester marks.
-- Calculate:
--   percentage = (marks / 500) * 100
--
-- Print:
--   1. Name
--   2. Marks
--   3. Percentage rounded to 2 decimal places
--   4. Today's date using SYSDATE
--   5. PASS or FAIL based on v_passed
--
-- Key points:
-- 1. VARCHAR2 is used for text.
-- 2. NUMBER is used for numerical values.
-- 3. DATE stores date values.
-- 4. BOOLEAN stores TRUE/FALSE.
-- 5. ROUND(value, 2) keeps the percentage to 2 decimals.
-- 6. SYSDATE gives the current database date.
-- 7. BOOLEAN values should be checked using IF before printing.
--
-- Personalised details:
-- Name    : Nirav Vala
-- Roll No : 33
-- Marks   : 456
-- ============================================================

DECLARE
    v_name       VARCHAR2(50) := 'Nikhil tak';
    v_marks      NUMBER(5,2) := 456;
    v_percentage NUMBER(5,2);
    v_dob        DATE := DATE '2006-11-22';
    v_passed     BOOLEAN;
BEGIN
    -- Calculate percentage from marks out of 500
    v_percentage := ROUND((v_marks / 500) * 100, 2);

    -- Student passes when percentage is 40 or above
    v_passed := (v_percentage >= 40);

    DBMS_OUTPUT.PUT_LINE('----------------------------------');
    DBMS_OUTPUT.PUT_LINE('        STUDENT DETAILS');
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
    DBMS_OUTPUT.PUT_LINE('Name       : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Roll No    : 50');
    DBMS_OUTPUT.PUT_LINE('Marks      : ' || v_marks);
    DBMS_OUTPUT.PUT_LINE('Percentage : ' || v_percentage || '%');
    DBMS_OUTPUT.PUT_LINE('Date       : ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY'));

    -- BOOLEAN cannot be directly concatenated with a string.
    -- Therefore, use IF to convert TRUE/FALSE into PASS/FAIL text.
    IF v_passed THEN
        DBMS_OUTPUT.PUT_LINE('Result     : PASS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Result     : FAIL');
    END IF;

    DBMS_OUTPUT.PUT_LINE('----------------------------------');
END;
/