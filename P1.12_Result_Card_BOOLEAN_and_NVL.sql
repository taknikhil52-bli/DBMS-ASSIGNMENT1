SET SERVEROUTPUT ON;

-- ============================================================
-- P1.12 - Result Card with BOOLEAN and NVL
--
-- Question:
-- Declare marks for 5 subjects:
--     v_m1, v_m2, v_m3, v_m4, v_m5
--
-- v_m5 must be NULL because the student was absent.
--
-- Requirements:
-- 1. Use NVL(v_m5, 0) while calculating the total.
-- 2. Calculate percentage out of 500.
-- 3. Declare a BOOLEAN variable v_passed.
-- 4. Student passes if percentage >= 40.
-- 5. Print total, percentage and result.
-- 6. Show the BOOLEAN limitation using a comment:
--    BOOLEAN cannot be directly printed using DBMS_OUTPUT.
-- 7. Use CASE or IF to convert BOOLEAN into PASS/FAIL text.
--
-- Key points:
-- 1. NULL means no value is available.
-- 2. NVL(NULL, 0) changes NULL into 0.
-- 3. BOOLEAN can store TRUE or FALSE.
-- 4. BOOLEAN cannot be directly concatenated with a string.
-- 5. IF is used to convert BOOLEAN into readable output.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Assignment formula:
-- Each subject mark = roll_no MOD 30 + 60
--
-- 50 MOD 30 + 60
-- = 3 + 60
-- = 63
--
-- Therefore:
-- v_m1 = 63
-- v_m2 = 63
-- v_m3 = 63
-- v_m4 = 63
-- v_m5 = NULL (Absent)
-- ============================================================

DECLARE
    v_m1 NUMBER;
    v_m2 NUMBER;
    v_m3 NUMBER;
    v_m4 NUMBER;
    v_m5 NUMBER;

    v_total NUMBER;
    v_percentage NUMBER;

    v_passed BOOLEAN;
BEGIN

    -- --------------------------------------------------------
    -- Generate the marks using the assignment's roll-number
    -- formula.
    -- --------------------------------------------------------

    v_m1 := MOD(33, 30) + 60;
    v_m2 := MOD(33, 30) + 60;
    v_m3 := MOD(33, 30) + 60;
    v_m4 := MOD(33, 30) + 60;

    -- Student was absent in subject 5.
    -- NULL represents the absence.
    v_m5 := NULL;


    -- --------------------------------------------------------
    -- Calculate total.
    --
    -- NVL(v_m5, 0) converts NULL to 0.
    --
    -- Without NVL:
    -- 63 + 63 + 63 + 63 + NULL = NULL
    --
    -- With NVL:
    -- 63 + 63 + 63 + 63 + 0 = 252
    -- --------------------------------------------------------

    v_total := v_m1
             + v_m2
             + v_m3
             + v_m4
             + NVL(v_m5, 0);


    -- --------------------------------------------------------
    -- Calculate percentage out of 500.
    -- --------------------------------------------------------

    v_percentage := ROUND(
        (v_total / 500) * 100,
        2
    );


    -- --------------------------------------------------------
    -- BOOLEAN stores the PASS/FAIL condition.
    -- --------------------------------------------------------

    v_passed := (v_percentage >= 40);


    -- --------------------------------------------------------
    -- Display result card.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('            STUDENT RESULT CARD');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name       : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No    : 50'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Subject 1  : ' || v_m1
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 2  : ' || v_m2
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 3  : ' || v_m3
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 4  : ' || v_m4
    );

    DBMS_OUTPUT.PUT_LINE(
        'Subject 5  : ABSENT'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Total      : ' || v_total || ' / 500'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Percentage : ' || v_percentage || '%'
    );


    -- --------------------------------------------------------
    -- IMPORTANT:
    --
    -- We cannot do:
    --
    -- DBMS_OUTPUT.PUT_LINE(v_passed);
    --
    -- because PL/SQL BOOLEAN cannot be directly displayed
    -- using DBMS_OUTPUT.PUT_LINE.
    --
    -- Therefore, IF is used to convert TRUE/FALSE into text.
    -- --------------------------------------------------------

    IF v_passed THEN

        DBMS_OUTPUT.PUT_LINE(
            'Result     : PASS'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Result     : FAIL'
        );

    END IF;

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/