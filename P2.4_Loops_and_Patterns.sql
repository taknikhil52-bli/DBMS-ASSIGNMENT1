SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.4 - LOOPS AND PATTERNS
--
-- Question:
--
-- Part A:
-- Print the multiplication table of:
--     (roll_no MOD 9 + 2)
-- from 1 to 20 using a FOR LOOP.
--
-- Part B:
-- Print all multiplication tables of 2, 3, 4 and 5
-- using nested FOR loops with LPAD alignment.
--
-- Part C:
-- Print a right-angled star triangle.
-- Height:
--     5 + roll_no MOD 5
--
-- Part D:
-- Print a number pyramid:
--     Row 1 -> 1
--     Row 2 -> 12
--     Row 3 -> 123
--     ...
--     for 6 rows.
--
-- Part E:
-- Print the same star triangle in REVERSE order,
-- with the tallest row first.
--
-- Key points:
-- 1. FOR LOOP automatically controls loop counting.
-- 2. Nested FOR loops are useful for tables and patterns.
-- 3. LPAD aligns multiplication results.
-- 4. REVERSE makes the FOR loop count backwards.
-- 5. A nested loop can print one character/value for
--    every column in each row.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Calculations:
--
-- Table number:
-- 50 MOD 9 + 2 = 8
--
-- Star height:
-- 5 + 33 MOD 5 = 8
-- ============================================================

DECLARE

    v_roll NUMBER := 50;
    v_table_number NUMBER;
    v_height NUMBER;

    v_result NUMBER;

BEGIN

    -- ========================================================
    -- Calculate personalised values.
    -- ========================================================

    v_table_number := MOD(v_roll, 9) + 2;

    v_height := 5 + MOD(v_roll, 5);


    -- ========================================================
    -- PART A
    -- Multiplication table of the personalised number.
    --
    -- Table number = 8
    -- Range = 1 to 20
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART A - TABLE OF ' || v_table_number
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    FOR i IN 1..20 LOOP

        v_result := v_table_number * i;

        DBMS_OUTPUT.PUT_LINE(
            v_table_number ||
            ' x ' ||
            LPAD(i, 2, ' ') ||
            ' = ' ||
            LPAD(v_result, 3, ' ')
        );

    END LOOP;


    -- ========================================================
    -- PART B
    -- Tables of 2, 3, 4 and 5.
    --
    -- Nested FOR loops:
    -- Outer loop  -> selects table.
    -- Inner loop  -> generates 1 to 10.
    --
    -- LPAD is used to keep the results aligned.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART B - TABLES OF 2, 3, 4 AND 5'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    FOR table_no IN 2..5 LOOP

        FOR i IN 1..10 LOOP

            v_result := table_no * i;

            DBMS_OUTPUT.PUT_LINE(
                LPAD(table_no, 2, ' ') ||
                ' x ' ||
                LPAD(i, 2, ' ') ||
                ' = ' ||
                LPAD(v_result, 3, ' ')
            );

        END LOOP;

        DBMS_OUTPUT.PUT_LINE(
            '--------------------------------------------'
        );

    END LOOP;


    -- ========================================================
    -- PART C
    -- Right-angled star triangle.
    --
    -- Height = 8 for Roll No. 33.
    --
    -- Outer loop  -> rows.
    -- Inner loop  -> stars in each row.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART C - RIGHT-ANGLED STAR TRIANGLE'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    FOR row_no IN 1..v_height LOOP

        FOR star_no IN 1..row_no LOOP

            DBMS_OUTPUT.PUT('* ');

        END LOOP;

        DBMS_OUTPUT.NEW_LINE;

    END LOOP;


    -- ========================================================
    -- PART D
    -- Number pyramid.
    --
    -- Row 1 -> 1
    -- Row 2 -> 12
    -- Row 3 -> 123
    -- ...
    -- Row 6 -> 123456
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART D - NUMBER PYRAMID'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    FOR row_no IN 1..6 LOOP

        FOR number_no IN 1..row_no LOOP

            DBMS_OUTPUT.PUT(number_no);

        END LOOP;

        DBMS_OUTPUT.NEW_LINE;

    END LOOP;


    -- ========================================================
    -- PART E
    -- REVERSE STAR TRIANGLE
    --
    -- REVERSE keyword makes the loop start from the largest
    -- value and move down to 1.
    --
    -- For height 8:
    --
    -- ********
    -- *******
    -- ******
    -- ...
    -- *
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART E - REVERSE STAR TRIANGLE'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    FOR row_no IN REVERSE 1..v_height LOOP

        FOR star_no IN 1..row_no LOOP

            DBMS_OUTPUT.PUT('* ');

        END LOOP;

        DBMS_OUTPUT.NEW_LINE;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

END;
/