SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.18 - Messy Name Cleaner
--
-- Question:
-- Admission forms may contain names with extra spaces and
-- incorrect letter case.
--
-- Example:
--     "  pankti   PATEL "
--
-- Perform the following:
-- 1. Remove leading and trailing spaces using TRIM().
-- 2. Collapse extra spaces using REPLACE().
-- 3. Apply INITCAP() to make the name properly formatted.
-- 4. Extract first name using SUBSTR() and INSTR().
-- 5. Extract last name.
-- 6. Generate college email:
--       firstname.lastname@ljku.edu.in
-- 7. Display LENGTH before and after cleaning.
--
-- The assignment says to apply REPLACE twice because one
-- replacement may not remove all consecutive spaces.
--
-- Key points:
-- 1. TRIM() removes spaces from the beginning and end.
-- 2. REPLACE() replaces unwanted spaces.
-- 3. INITCAP() converts text into proper name case.
-- 4. INSTR() finds the position of a space.
-- 5. SUBSTR() extracts a part of the name.
-- 6. LOWER() converts the email address to lowercase.
-- 7. LENGTH() returns the number of characters.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- To demonstrate cleaning, the name is intentionally written
-- with extra spaces and mixed case.
-- ============================================================

DECLARE
    -- Intentionally messy version of the student's name.
    v_raw VARCHAR2(100) := '  nikhil   TAK  ';

    v_clean  VARCHAR2(100);
    v_first  VARCHAR2(50);
    v_last   VARCHAR2(50);
    v_email  VARCHAR2(100);

    v_before_length NUMBER;
    v_after_length  NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Store the original length before cleaning.
    -- --------------------------------------------------------

    v_before_length := LENGTH(v_raw);


    -- --------------------------------------------------------
    -- Step 1:
    -- TRIM removes leading and trailing spaces.
    -- --------------------------------------------------------

    v_clean := TRIM(v_raw);


    -- --------------------------------------------------------
    -- Step 2:
    -- Replace double spaces.
    --
    -- REPLACE is applied twice because a single replacement
    -- may leave extra spaces when several spaces occur together.
    -- --------------------------------------------------------

    v_clean := REPLACE(v_clean, '  ', ' ');
    v_clean := REPLACE(v_clean, '  ', ' ');


    -- --------------------------------------------------------
    -- Step 3:
    -- INITCAP converts the cleaned name into proper case.
    --
    -- "nikhil tak" becomes "Nikhil tak".
    -- --------------------------------------------------------

    v_clean := INITCAP(v_clean);


    -- --------------------------------------------------------
    -- Step 4:
    -- Extract the first name.
    --
    -- INSTR finds the first space.
    -- SUBSTR extracts everything before that space.
    -- --------------------------------------------------------

    v_first := SUBSTR(
        v_clean,
        1,
        INSTR(v_clean, ' ') - 1
    );


    -- --------------------------------------------------------
    -- Step 5:
    -- Extract the last name.
    -- --------------------------------------------------------

    v_last := SUBSTR(
        v_clean,
        INSTR(v_clean, ' ') + 1
    );


    -- --------------------------------------------------------
    -- Step 6:
    -- Generate college email address.
    --
    -- LOWER() makes the email lowercase.
    -- --------------------------------------------------------

    v_email := LOWER(
        v_first || '.' ||
        v_last ||
        '@ljku.edu.in'
    );


    -- --------------------------------------------------------
    -- Step 7:
    -- Store the length after cleaning.
    -- --------------------------------------------------------

    v_after_length := LENGTH(v_clean);


    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          MESSY NAME CLEANER');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name     : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No  : 50'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Original : [' || v_raw || ']'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Cleaned  : [' || v_clean || ']'
    );

    DBMS_OUTPUT.PUT_LINE(
        'First    : ' || v_first
    );

    DBMS_OUTPUT.PUT_LINE(
        'Last     : ' || v_last
    );

    DBMS_OUTPUT.PUT_LINE(
        'Email    : ' || v_email
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Length Before Cleaning : ' ||
        v_before_length
    );

    DBMS_OUTPUT.PUT_LINE(
        'Length After Cleaning  : ' ||
        v_after_length
    );

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/