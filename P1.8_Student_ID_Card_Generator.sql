SET SERVEROUTPUT ON;

-- ============================================================
-- P1.8 - Student ID Card Generator
--
-- Question:
-- Build an "LJICA Student ID Card Generator".
--
-- Input:
--   1. Full name
--   2. Roll number
--   3. Date of birth
--
-- Perform:
--   1. Convert name to UPPER using UPPER().
--   2. Extract first name using SUBSTR() and INSTR().
--   3. Generate Student ID:
--        LJICA + Birth Year + Roll Number
--      Example:
--        LJICA2004005
--   4. Calculate age using MONTHS_BETWEEN().
--   5. Use LPAD/RPAD to create a formatted ID card.
--   6. Use LENGTH() to check name length.
--   7. Use REPLACE() for the optional last-name abbreviation.
--
-- Bonus:
-- If full name length is greater than 20 characters,
-- abbreviate the last name to its first initial.
--
-- Key points:
-- 1. UPPER() converts text into uppercase.
-- 2. INSTR() finds the position of a character.
-- 3. SUBSTR() extracts part of a string.
-- 4. LPAD() adds characters to the left.
-- 5. RPAD() adds characters to the right.
-- 6. LENGTH() returns the number of characters.
-- 7. TO_CHAR() formats dates and numbers.
-- 8. MONTHS_BETWEEN() helps calculate age from DOB.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- IMPORTANT:
-- Replace the temporary DOB below with your ACTUAL DOB
-- before submitting this practical.
-- ============================================================

DECLARE
    v_name       VARCHAR2(100) := 'Nikhil tak';
    v_roll       NUMBER := 50;

    -- Temporary DOB for testing.
    -- Replace this with your actual DOB.
    v_dob        DATE := DATE '2007-10-15';

    v_upper_name VARCHAR2(100);
    v_first_name VARCHAR2(50);
    v_last_name  VARCHAR2(50);

    v_student_id VARCHAR2(30);
    v_age        NUMBER;

    v_display_name VARCHAR2(100);
BEGIN

    -- --------------------------------------------------------
    -- Step 1: Convert the complete name to uppercase.
    -- --------------------------------------------------------

    v_upper_name := UPPER(v_name);


    -- --------------------------------------------------------
    -- Step 2: Extract the first name.
    --
    -- INSTR finds the first space.
    -- SUBSTR extracts everything before that space.
    --
    -- Example:
    -- "Nikhil tak"
    --      ↓
    -- First name = "Nikhil"
    -- --------------------------------------------------------

    v_first_name := SUBSTR(
        v_name,
        1,
        INSTR(v_name, ' ') - 1
    );


    -- --------------------------------------------------------
    -- Step 3: Extract the last name.
    --
    -- The part after the first space is taken as the
    -- last name for this practical.
    -- --------------------------------------------------------

    v_last_name := SUBSTR(
        v_name,
        INSTR(v_name, ' ') + 1
    );


    -- --------------------------------------------------------
    -- Step 4: Generate the Student ID.
    --
    -- Format:
    -- LJICA + YYYY + 3-digit roll number
    --
    -- Roll 50 becomes 050.
    -- --------------------------------------------------------

    v_student_id :=
        'LJICA' ||
        TO_CHAR(v_dob, 'YYYY') ||
        LPAD(v_roll, 3, '0');


    -- --------------------------------------------------------
    -- Step 5: Calculate age.
    --
    -- MONTHS_BETWEEN gives the difference in months.
    -- Divide by 12 and use TRUNC to get completed years.
    -- --------------------------------------------------------

    v_age := TRUNC(
        MONTHS_BETWEEN(SYSDATE, v_dob) / 12
    );


    -- --------------------------------------------------------
    -- Step 6: Bonus condition.
    --
    -- If the full name is longer than 20 characters,
    -- abbreviate the last name to its first initial.
    --
    -- Nirav Vala is not longer than 20 characters, so the
    -- complete name will be displayed.
    -- --------------------------------------------------------

    IF LENGTH(v_name) > 20 THEN

        v_display_name :=
            v_first_name || ' ' ||
            SUBSTR(v_last_name, 1, 1) || '.';

    ELSE

        v_display_name := v_name;

    END IF;


    -- --------------------------------------------------------
    -- Step 7: Display the formatted student ID card.
    --
    -- RPAD is used for labels so the values line up.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('          LJICA STUDENT ID CARD', 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Name        : ' || v_display_name, 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Name Upper  : ' || v_upper_name, 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('First Name  : ' || v_first_name, 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Last Name   : ' || v_last_name, 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD(
            'Student ID  : ' || v_student_id,
            42
        ) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD(
            'DOB         : ' ||
            TO_CHAR(v_dob, 'DD-MON-YYYY'),
            42
        ) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD(
            'Age         : ' || v_age || ' years',
            42
        ) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD(
            'Name Length : ' || LENGTH(v_name),
            42
        ) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

END;
/