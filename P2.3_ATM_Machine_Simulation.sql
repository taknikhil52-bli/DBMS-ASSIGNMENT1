SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.3 - ATM MACHINE SIMULATION
--
-- Question:
-- Simulate an ATM using LOOP and EXIT WHEN.
--
-- Initial balance:
--     roll_no * 500 + 5000
--
-- Rules for withdrawal:
-- 1. Withdrawal must be greater than 0.
-- 2. Withdrawal must be a multiple of 100.
-- 3. Maximum withdrawal per transaction = Rs.10,000.
-- 4. Withdrawal cannot exceed the available balance.
--
-- Requirements:
-- 1. Use LOOP.
-- 2. Use a simulated menu through v_choice.
-- 3. Count successful transactions.
-- 4. EXIT WHEN v_choice = 3 OR balance = 0.
-- 5. Run at least 4 iterations.
-- 6. Print a transaction receipt for each successful
--    withdrawal.
-- 7. Print final summary:
--       Total transactions
--       Total withdrawn
--       Closing balance
--
-- Key points:
-- 1. LOOP repeats the ATM menu.
-- 2. EXIT WHEN stops the loop when the exit condition occurs.
-- 3. IF-ELSIF validates the withdrawal amount.
-- 4. The balance is updated after every successful withdrawal.
-- 5. Only successful withdrawals increase the transaction
--    counter.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Initial balance:
-- 33 * 500 + 5000 = Rs.21,500
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- ATM variables
    -- --------------------------------------------------------

    v_balance NUMBER;
    v_withdraw NUMBER;

    v_total_withdrawn NUMBER := 0;
    v_transaction_count NUMBER := 0;

    v_choice NUMBER;

    -- --------------------------------------------------------
    -- Simulated menu sequence.
    --
    -- 1 = Withdraw
    -- 2 = Check Balance
    -- 3 = Exit
    --
    -- Four iterations are deliberately provided.
    -- --------------------------------------------------------

    v_iteration NUMBER := 0;

BEGIN

    -- ========================================================
    -- INITIAL BALANCE
    -- ========================================================

    v_balance :=
        v_roll * 500 + 5000;


    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '              ATM SIMULATOR'
    );

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Customer : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No  : ' || v_roll
    );

    DBMS_OUTPUT.PUT_LINE(
        'Initial Balance : Rs.' || v_balance
    );

    DBMS_OUTPUT.PUT_LINE(
        '--------------------------------------------'
    );


    -- ========================================================
    -- ATM LOOP
    -- ========================================================

    LOOP

        -- ----------------------------------------------------
        -- Increase iteration number.
        -- ----------------------------------------------------

        v_iteration := v_iteration + 1;


        -- ----------------------------------------------------
        -- Simulated menu.
        --
        -- Iteration 1 -> Withdraw
        -- Iteration 2 -> Withdraw
        -- Iteration 3 -> Check Balance
        -- Iteration 4 -> Withdraw
        -- Iteration 5 -> Exit
        --
        -- This allows the LOOP to demonstrate multiple
        -- iterations without requiring keyboard input.
        -- ----------------------------------------------------

        IF v_iteration = 1 THEN

            v_choice := 1;
            v_withdraw := 500;

        ELSIF v_iteration = 2 THEN

            v_choice := 1;
            v_withdraw := 1000;

        ELSIF v_iteration = 3 THEN

            v_choice := 2;

        ELSIF v_iteration = 4 THEN

            v_choice := 1;
            v_withdraw := 3200;

        ELSE

            v_choice := 3;

        END IF;


        -- ====================================================
        -- EXIT OPTION
        -- ====================================================

        EXIT WHEN v_choice = 3
                  OR v_balance = 0;


        -- ====================================================
        -- WITHDRAWAL OPTION
        -- ====================================================

        IF v_choice = 1 THEN

            -- ------------------------------------------------
            -- Validate withdrawal amount.
            -- ------------------------------------------------

            IF v_withdraw <= 0 THEN

                DBMS_OUTPUT.PUT_LINE(
                    'ERROR: Withdrawal must be greater than zero.'
                );


            ELSIF MOD(v_withdraw, 100) <> 0 THEN

                DBMS_OUTPUT.PUT_LINE(
                    'ERROR: Withdrawal must be a multiple of Rs.100.'
                );


            ELSIF v_withdraw > 10000 THEN

                DBMS_OUTPUT.PUT_LINE(
                    'ERROR: Maximum withdrawal is Rs.10,000 per transaction.'
                );


            ELSIF v_withdraw > v_balance THEN

                DBMS_OUTPUT.PUT_LINE(
                    'ERROR: Insufficient balance.'
                );


            ELSE

                -- ------------------------------------------------
                -- Successful withdrawal.
                -- ------------------------------------------------

                v_balance :=
                    v_balance - v_withdraw;

                v_transaction_count :=
                    v_transaction_count + 1;

                v_total_withdrawn :=
                    v_total_withdrawn + v_withdraw;


                -- ------------------------------------------------
                -- Transaction receipt.
                -- ------------------------------------------------

                DBMS_OUTPUT.PUT_LINE(
                    'TRANSACTION #' ||
                    v_transaction_count
                );

                DBMS_OUTPUT.PUT_LINE(
                    'Withdrawal    : Rs.' ||
                    v_withdraw
                );

                DBMS_OUTPUT.PUT_LINE(
                    'Remaining Bal.: Rs.' ||
                    v_balance
                );

                DBMS_OUTPUT.PUT_LINE(
                    '--------------------------------------------'
                );

            END IF;


        -- ====================================================
        -- BALANCE CHECK OPTION
        -- ====================================================

        ELSIF v_choice = 2 THEN

            DBMS_OUTPUT.PUT_LINE(
                'Balance Check : Rs.' ||
                v_balance
            );

            DBMS_OUTPUT.PUT_LINE(
                '--------------------------------------------'
            );

        END IF;


    END LOOP;


    -- ========================================================
    -- FINAL SUMMARY
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '              ATM FINAL SUMMARY'
    );

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Transactions Done : ' ||
        v_transaction_count
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total Withdrawn   : Rs.' ||
        v_total_withdrawn
    );

    DBMS_OUTPUT.PUT_LINE(
        'Closing Balance   : Rs.' ||
        v_balance
    );

    DBMS_OUTPUT.PUT_LINE(
        '============================================'
    );

END;
/