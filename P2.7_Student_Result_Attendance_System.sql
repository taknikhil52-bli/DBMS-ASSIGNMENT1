SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.7 - STUDENT RESULT + ATTENDANCE SYSTEM
--
-- Question:
-- Build an LJICA semester result system.
--
-- Variables:
--   attendance_pct
--   theory_marks       (out of 70)
--   practical_marks    (out of 30)
--   assignment_marks   (out of 20, maximum 10 counted)
--
-- Rules:
--
-- 1. Attendance below 40%:
--       DETAINED
--
-- 2. Theory below 28:
--       FAIL in Theory
--       (28 is 40% of 70)
--
-- 3. Practical below 12:
--       FAIL in Practical
--       (12 is 40% of 30)
--
-- 4. If all required conditions are passed:
--       Total = theory + practical + MIN(assignment,10)
--
-- 5. Print:
--       Attendance
--       Theory
--       Practical
--       Assignment
--       Counted Assignment
--       Total
--       Percentage
--       Grade using CASE
--       Result
--       One-line remark
--
-- Key points:
-- 1. ELSIF ladder is used to check result conditions.
-- 2. CASE is used for grade calculation.
-- 3. Attendance has the highest priority.
-- 4. Theory and practical have separate passing conditions.
-- 5. MIN(assignment_marks, 10) ensures that only 10 assignment
--    marks can contribute to the final total.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Test data:
-- Attendance       = 88%
-- Theory           = 55 / 70
-- Practical        = 26 / 30
-- Assignment       = 18 / 20
--
-- Counted assignment:
-- MIN(18,10) = 10
--
-- Total:
-- 55 + 26 + 10 = 91 / 110
--
-- Percentage:
-- (91 / 110) * 100 = 82.73%
--
-- Expected Grade:
-- A
--
-- Expected Result:
-- PASS
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- Semester marks and attendance
    -- --------------------------------------------------------

    v_attendance_pct NUMBER := 88;

    v_theory_marks NUMBER := 55;

    v_practical_marks NUMBER := 26;

    v_assignment_marks NUMBER := 18;


    -- --------------------------------------------------------
    -- Calculated values
    -- --------------------------------------------------------

    v_counted_assignment NUMBER;

    v_total NUMBER := 0;

    v_percentage NUMBER := 0;


    -- --------------------------------------------------------
    -- Result information
    -- --------------------------------------------------------

    v_grade VARCHAR2(5);

    v_result VARCHAR2(30);

    v_remark VARCHAR2(100);

BEGIN

    -- ========================================================
    -- STEP 1: Count maximum 10 assignment marks.
    --
    -- Even if the student scores 18/20, only 10 marks
    -- contribute to the semester total.
    -- ========================================================

    v_counted_assignment :=
        LEAST(v_assignment_marks, 10);


    -- ========================================================
    -- STEP 2: Check result conditions.
    --
    -- ELSIF ladder is used as required by the assignment.
    --
    -- Attendance is checked first because attendance below
    -- 40% automatically results in DETAINED.
    -- ========================================================

    IF v_attendance_pct < 40 THEN

        v_result := 'DETAINED';

        v_remark :=
            'Attendance below 40% - student is detained.';

        v_total := 0;

        v_percentage := 0;


    ELSIF v_theory_marks < 28 THEN

        v_result := 'FAIL - THEORY';

        v_remark :=
            'Theory marks are below the minimum passing marks.';

        v_total :=
            v_theory_marks
            + v_practical_marks
            + v_counted_assignment;

        v_percentage :=
            ROUND((v_total / 110) * 100, 2);


    ELSIF v_practical_marks < 12 THEN

        v_result := 'FAIL - PRACTICAL';

        v_remark :=
            'Practical marks are below the minimum passing marks.';

        v_total :=
            v_theory_marks
            + v_practical_marks
            + v_counted_assignment;

        v_percentage :=
            ROUND((v_total / 110) * 100, 2);


    ELSE

        -- ----------------------------------------------------
        -- All attendance and subject passing conditions are met.
        -- ----------------------------------------------------

        v_total :=
            v_theory_marks
            + v_practical_marks
            + v_counted_assignment;

        v_percentage :=
            ROUND((v_total / 110) * 100, 2);

        v_result := 'PASS';

        v_remark :=
            'All academic and attendance requirements satisfied.';

    END IF;


    -- ========================================================
    -- STEP 3: Grade calculation using CASE.
    --
    -- Grade is calculated only when the student is not detained
    -- or failed in a subject.
    -- ========================================================

    v_grade :=
        CASE
            WHEN v_result = 'PASS'
                 AND v_percentage >= 90 THEN
                'A+'

            WHEN v_result = 'PASS'
                 AND v_percentage >= 80 THEN
                'A'

            WHEN v_result = 'PASS'
                 AND v_percentage >= 70 THEN
                'B'

            WHEN v_result = 'PASS'
                 AND v_percentage >= 60 THEN
                'C'

            WHEN v_result = 'PASS'
                 AND v_percentage >= 50 THEN
                'D'

            ELSE
                'F'
        END;


    -- ========================================================
    -- STEP 4: Print marksheet.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '          LJICA SEMESTER RESULT'
    );

    DBMS_OUTPUT.PUT_LINE(
        '       STUDENT RESULT + ATTENDANCE'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Name              : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No           : ' || v_roll
    );

    DBMS_OUTPUT.PUT_LINE(
        '------------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Attendance        : ' ||
        v_attendance_pct || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Theory Marks      : ' ||
        v_theory_marks || ' / 70'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Practical Marks   : ' ||
        v_practical_marks || ' / 30'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Assignment Marks  : ' ||
        v_assignment_marks || ' / 20'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Assignment Counted: ' ||
        v_counted_assignment || ' / 10'
    );

    DBMS_OUTPUT.PUT_LINE(
        '------------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total             : ' ||
        v_total || ' / 110'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Percentage        : ' ||
        v_percentage || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Grade             : ' ||
        v_grade
    );

    DBMS_OUTPUT.PUT_LINE(
        'Result            : ' ||
        v_result
    );

    DBMS_OUTPUT.PUT_LINE(
        'Remark            : ' ||
        v_remark
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

END;
/