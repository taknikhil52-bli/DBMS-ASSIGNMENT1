SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.19 - Bank Branch Hierarchy - Nested Scope
--
-- Question:
-- Model a bank using 3 nested PL/SQL blocks.
--
-- OUTER BLOCK:
--   Label       : bank
--   v_bank      : 'LJ Bank'
--   v_total_deposit = 0
--
-- MIDDLE BLOCK:
--   Label       : branch
--   v_branch    : student's home city
--   Add deposit into bank.v_total_deposit
--
-- INNER BLOCK:
--   Label       : counter
--   Declare v_token
--   Print bank name + branch + token
--
-- After the inner block ends:
--   Demonstrate that v_token is no longer available.
--
-- Finally:
--   Print total deposit at bank level.
--
-- Required scope concept:
-- An inner block can access variables from its outer blocks.
-- An outer block cannot access variables declared inside
-- an inner block.
--
-- The assignment asks to uncomment the v_token line once
-- and observe the PLS-00201 error.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
-- Home City: Ahmedabad
-- Deposit : 50 * 1000 = Rs.50,000
-- ============================================================


<<bank>>

DECLARE
    -- --------------------------------------------------------
    -- OUTER BLOCK VARIABLES
    -- --------------------------------------------------------

    v_bank VARCHAR2(30) := 'LJ Bank';

    v_total_deposit NUMBER := 0;

BEGIN

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '       BANK BRANCH HIERARCHY'
    );

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );


    -- ========================================================
    -- MIDDLE BLOCK
    -- ========================================================

    <<branch>>

    DECLARE
        v_branch VARCHAR2(30) := 'Ahmedabad';

        v_deposit NUMBER := 33 * 1000;

    BEGIN

        -- ----------------------------------------------------
        -- Add the branch deposit to the variable declared
        -- in the outer bank block.
        --
        -- The label "bank" explicitly identifies the outer
        -- block variable.
        -- ----------------------------------------------------

        bank.v_total_deposit :=
            bank.v_total_deposit + v_deposit;


        DBMS_OUTPUT.PUT_LINE(
            'Bank       : ' || bank.v_bank
        );

        DBMS_OUTPUT.PUT_LINE(
            'Branch     : ' || v_branch
        );

        DBMS_OUTPUT.PUT_LINE(
            'Deposit    : Rs.' || v_deposit
        );


        -- ====================================================
        -- INNER BLOCK
        -- ====================================================

        <<counter>>

        DECLARE
            -- Local variable of the inner block.
            v_token NUMBER := 1;

        BEGIN

            -- ------------------------------------------------
            -- The inner block can access:
            --
            -- 1. bank.v_bank     -> outer block
            -- 2. v_branch        -> middle block
            -- 3. v_token         -> current block
            --
            -- This demonstrates nested scope.
            -- ------------------------------------------------

            DBMS_OUTPUT.PUT_LINE(
                '----------------------------------------'
            );

            DBMS_OUTPUT.PUT_LINE(
                'Counter Token: ' ||
                bank.v_bank ||
                ' | ' ||
                v_branch ||
                ' | Token ' ||
                v_token
            );

            DBMS_OUTPUT.PUT_LINE(
                'Inner block can read both outer levels.'
            );

        END counter;


        -- ----------------------------------------------------
        -- The inner block has ended.
        --
        -- v_token belonged only to the counter block.
        -- Therefore it cannot be accessed here.
        --
        -- DO NOT uncomment the following line during the
        -- normal successful run.
        --
        -- DBMS_OUTPUT.PUT_LINE(v_token);
        --
        -- If uncommented, Oracle will report:
        --
        -- PLS-00201: identifier 'V_TOKEN' must be declared
        --
        -- This proves that an outer block cannot access a
        -- variable declared inside its inner block.
        -- ----------------------------------------------------


        DBMS_OUTPUT.PUT_LINE(
            'Inner block ended - v_token is out of scope.'
        );

    END branch;


    -- ========================================================
    -- BACK TO OUTER BANK BLOCK
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total Bank Deposit : Rs.' ||
        bank.v_total_deposit
    );

    DBMS_OUTPUT.PUT_LINE(
        '========================================'
    );

END bank;
/