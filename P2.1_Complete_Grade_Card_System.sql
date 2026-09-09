SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.1 - COMPLETE GRADE CARD SYSTEM
--
-- Question:
-- Input marks for 5 subjects using variables.
--
-- Requirements:
-- 1. Calculate total and percentage.
--
-- 2. Use IF-ELSIF for grade:
--       >= 90  -> A+
--       >= 80  -> A
--       >= 70  -> B
--       >= 60  -> C
--       >= 50  -> D
--       <  50  -> FAIL
--
-- 3. If ANY subject is below 35:
--       Result = DETAINED
--       Print which subject failed.
--
-- 4. If ALL subjects are passed:
--       >= 75% -> Distinction
--       >= 60% -> First Class
--       >= 50% -> Second Class
--       <  50% -> Pass
--
-- 5. Print a complete report card.
--
-- Key points:
-- 1. IF-ELSIF is used for grade calculation.
-- 2. Nested IF is used for the detained/classification logic.
-- 3. Boolean conditions are used to check whether each
--    subject has passed.
-- 4. A subject requires at least 35 marks to pass.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Marks used for this practical:
-- Subject 1 = 73
-- Subject 2 = 78
-- Subject 3 = 81
-- Subject 4 = 69
-- Subject 5 = 75
--
-- Total = 376 / 500
-- Percentage = 75.20%
-- Expected Class = Distinction
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- Marks for five subjects
    -- --------------------------------------------------------

    v_m1 NUMBER := 73;
    v_m2 NUMBER := 78;
    v_m3 NUMBER := 81;
    v_m4 NUMBER := 69;
    v_m5 NUMBER := 75;


    -- --------------------------------------------------------
    -- Result variables
    -- --------------------------------------------------------

    v_total      NUMBER;
    v_percentage NUMBER;

    v_grade       VARCHAR2(10);
    v_result      VARCHAR2(30);
    v_class       VARCHAR2(30);

    -- Boolean variables for subject pass status.
    v_s1_pass BOOLEAN;
    v_s2_pass BOOLEAN;
    v_s3_pass BOOLEAN;
    v_s4_pass BOOLEAN;
    v_s5_pass BOOLEAN;

BEGIN

    -- ========================================================
    -- STEP 1: Calculate total marks.
    -- ========================================================

    v_total :=
        v_m1 + v_m2 + v_m3 + v_m4 + v_m5;


    -- ========================================================
    -- STEP 2: Calculate percentage.
    -- ========================================================

    v_percentage :=
        ROUND((v_total / 500) * 100, 2);


    -- ========================================================
    -- STEP 3: Check each subject.
    --
    -- Minimum passing mark = 35.
    -- ========================================================

    v_s1_pass := (v_m1 >= 35);
    v_s2_pass := (v_m2 >= 35);
    v_s3_pass := (v_m3 >= 35);
    v_s4_pass := (v_m4 >= 35);
    v_s5_pass := (v_m5 >= 35);


    -- ========================================================
    -- STEP 4: Grade calculation using IF-ELSIF.
    --
    -- This is based on overall percentage.
    -- ========================================================

    IF v_percentage >= 90 THEN

        v_grade := 'A+';

    ELSIF v_percentage >= 80 THEN

        v_grade := 'A';

    ELSIF v_percentage >= 70 THEN

        v_grade := 'B';

    ELSIF v_percentage >= 60 THEN

        v_grade := 'C';

    ELSIF v_percentage >= 50 THEN

        v_grade := 'D';

    ELSE

        v_grade := 'FAIL';

    END IF;


    -- ========================================================
    -- STEP 5: Check whether any subject has failed.
    --
    -- Nested IF is used to print the failed subject.
    -- ========================================================

    IF NOT v_s1_pass
       OR NOT v_s2_pass
       OR NOT v_s3_pass
       OR NOT v_s4_pass
       OR NOT v_s5_pass THEN

        v_result := 'DETAINED';
        v_class := 'Not Applicable';

        -- ----------------------------------------------------
        -- Print the subjects that failed.
        -- ----------------------------------------------------

        IF NOT v_s1_pass THEN
            DBMS_OUTPUT.PUT_LINE(
                'Failed Subject: Subject 1'
            );
        END IF;

        IF NOT v_s2_pass THEN
            DBMS_OUTPUT.PUT_LINE(
                'Failed Subject: Subject 2'
            );
        END IF;

        IF NOT v_s3_pass THEN
            DBMS_OUTPUT.PUT_LINE(
                'Failed Subject: Subject 3'
            );
        END IF;

        IF NOT v_s4_pass THEN
            DBMS_OUTPUT.PUT_LINE(
                'Failed Subject: Subject 4'
            );
        END IF;

        IF NOT v_s5_pass THEN
            DBMS_OUTPUT.PUT_LINE(
                'Failed Subject: Subject 5'
            );
        END IF;


    ELSE

        -- ----------------------------------------------------
        -- All subjects have passed.
        -- Now determine class based on percentage.
        -- ----------------------------------------------------

        v_result := 'PASS';

        IF v_percentage >= 75 THEN

            v_class := 'Distinction';

        ELSIF v_percentage >= 60 THEN

            v_class := 'First Class';

        ELSIF v_percentage >= 50 THEN

            v_class := 'Second Class';

        ELSE

            v_class := 'Pass';

        END IF;

    END IF;


    -- ========================================================
    -- STEP 6: PRINT REPORT CARD
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '              LJICA RESULT CARD'
    );

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Name        : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No     : ' || v_roll
    );

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 1   : ' || v_m1
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 2   : ' || v_m2
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 3   : ' || v_m3
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 4   : ' || v_m4
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 5   : ' || v_m5
    );

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total       : ' || v_total || ' / 500'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Percentage  : ' || v_percentage || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Grade       : ' || v_grade
    );

    DBMS_OUTPUT.PUT_LINE(
        'Result      : ' || v_result
    );

    DBMS_OUTPUT.PUT_LINE(
        'Class       : ' || v_class
    );

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

END;
/