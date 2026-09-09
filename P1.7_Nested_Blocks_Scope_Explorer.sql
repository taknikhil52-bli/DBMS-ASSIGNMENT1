SET SERVEROUTPUT ON;

-- ============================================================
-- P1.7 - Nested Blocks - Scope Explorer
--
-- Question:
-- Create 3 levels of nested PL/SQL blocks.
--
-- OUTER BLOCK:
--   v_city = your home city/district
--   v_num  = 100
--
-- MIDDLE BLOCK:
--   v_city = 'Ahmedabad'  -> shadows the outer v_city
--   v_num  = 200
--
-- INNER BLOCK:
--   v_num = 300
--
-- Inside each level, print the available variables.
-- After the middle block ends, prove that the outer v_city
-- is still unchanged.
--
-- Use block labels:
--   <<outer>>
--   <<middle>>
--
-- Also demonstrate accessing the outer variable from the
-- inner block using:
--   outer.v_city
--
-- Key points:
-- 1. An inner block can access variables declared by its
--    outer block.
-- 2. A variable declared again inside an inner block hides
--    the variable with the same name from the outer block.
--    This is called variable shadowing.
-- 3. Block labels allow us to explicitly refer to an outer
--    variable.
-- 4. After an inner block ends, its local variables disappear.
--
-- Personalised detail:
-- Name    : Nikhil tak
-- Roll No : 50
-- Home city/district: Ahmedabad
--
-- ============================================================

<<outer>>

DECLARE
    -- Outer block variables
    v_city VARCHAR2(30) := 'Ahmedabad';
    v_num  NUMBER := 100;

BEGIN

    -- --------------------------------------------------------
    -- OUTER BLOCK
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          OUTER BLOCK');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'City : ' || v_city
    );

    DBMS_OUTPUT.PUT_LINE(
        'Number : ' || v_num
    );


    -- ========================================================
    -- MIDDLE BLOCK
    -- ========================================================

    <<middle>>

    DECLARE
        -- This v_city hides outer.v_city.
        v_city VARCHAR2(30) := 'Ahmedabad';

        -- This is a new variable with the same name as
        -- outer.v_num, so it also hides the outer variable.
        v_num NUMBER := 200;

    BEGIN

        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        DBMS_OUTPUT.PUT_LINE('          MIDDLE BLOCK');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');

        DBMS_OUTPUT.PUT_LINE(
            'City : ' || v_city
        );

        DBMS_OUTPUT.PUT_LINE(
            'Number : ' || v_num
        );

        -- Explicitly access the outer block's city.
        DBMS_OUTPUT.PUT_LINE(
            'Outer City : ' || outer.v_city
        );


        -- ====================================================
        -- INNER BLOCK
        -- ====================================================

        DECLARE
            -- This v_num hides middle.v_num.
            v_num NUMBER := 300;

        BEGIN

            DBMS_OUTPUT.PUT_LINE('----------------------------------------');
            DBMS_OUTPUT.PUT_LINE('          INNER BLOCK');
            DBMS_OUTPUT.PUT_LINE('----------------------------------------');

            DBMS_OUTPUT.PUT_LINE(
                'City : ' || v_city
            );

            DBMS_OUTPUT.PUT_LINE(
                'Number : ' || v_num
            );

            -- The inner block can access the outer block's
            -- variable through the block label.
            DBMS_OUTPUT.PUT_LINE(
                'Outer City : ' || outer.v_city
            );

        END;


        -- ----------------------------------------------------
        -- INNER BLOCK HAS ENDED.
        -- The inner v_num = 300 no longer exists.
        -- The middle v_num = 200 becomes visible again.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        DBMS_OUTPUT.PUT_LINE(
            'After Inner Block - Middle Number : ' || v_num
        );

    END;


    -- --------------------------------------------------------
    -- MIDDLE BLOCK HAS ENDED.
    --
    -- The middle variables no longer exist.
    -- Therefore the outer variables become visible again.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('       AFTER MIDDLE BLOCK');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Outer City : ' || v_city
    );

    DBMS_OUTPUT.PUT_LINE(
        'Outer Number : ' || v_num
    );

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/