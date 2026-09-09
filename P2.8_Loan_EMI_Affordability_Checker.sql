SET SERVEROUTPUT ON;

-- ============================================================
-- P2.8 - LOAN EMI AFFORDABILITY CHECKER
--
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Question:
-- Check loan affordability using FOIR.
--
-- Rules:
-- 1. FOIR = 40% of monthly salary.
-- 2. Minimum salary = Rs.25,000.
-- 3. Maximum loan = 60 x monthly salary.
-- 4. Calculate EMI using the standard EMI formula.
-- 5. If EMI exceeds FOIR, reduce loan by Rs.10,000
--    using a WHILE LOOP.
-- 6. Use CASE for final decision.
--
-- Key points:
-- 1. FOIR checks total monthly EMI affordability.
-- 2. Existing EMI is included in FOIR calculation.
-- 3. WHILE LOOP reduces the loan amount when required.
-- 4. CASE determines the final decision.
-- ============================================================

DECLARE

    -- ========================================================
    -- STUDENT DETAILS
    -- ========================================================

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- ========================================================
    -- LOAN INPUTS
    -- ========================================================

    v_salary NUMBER := 58000;
    v_existing_emi NUMBER := 3300;
    v_loan NUMBER := 530000;

    v_rate NUMBER := 9;
    v_months NUMBER := 60;


    -- ========================================================
    -- CALCULATION VARIABLES
    -- ========================================================

    v_monthly_rate NUMBER;
    v_foir NUMBER;
    v_max_loan NUMBER;

    v_emi NUMBER := 0;
    v_total_emi NUMBER := 0;

    v_approved_loan NUMBER := 0;
    v_approved_emi NUMBER := 0;

    v_count NUMBER := 0;

    v_decision VARCHAR2(20);


BEGIN

    -- ========================================================
    -- STEP 1: Calculate monthly interest rate
    --
    -- Annual Rate = 9%
    -- Monthly Rate = 9 / 12 / 100
    -- ========================================================

    v_monthly_rate := v_rate / 12 / 100;


    -- ========================================================
    -- STEP 2: Calculate FOIR
    --
    -- FOIR = 40% of monthly salary
    -- ========================================================

    v_foir := v_salary * 0.40;


    -- ========================================================
    -- STEP 3: Calculate maximum loan
    --
    -- Maximum Loan = 60 x Monthly Salary
    -- ========================================================

    v_max_loan := v_salary * 60;


    -- ========================================================
    -- STEP 4: Check minimum salary
    -- ========================================================

    IF v_salary < 25000 THEN

        v_approved_loan := 0;
        v_approved_emi := 0;
        v_total_emi := v_existing_emi;

    ELSE

        -- ====================================================
        -- STEP 5: Apply maximum loan limit
        -- ====================================================

        IF v_loan > v_max_loan THEN

            v_approved_loan := v_max_loan;

        ELSE

            v_approved_loan := v_loan;

        END IF;


        -- ====================================================
        -- STEP 6: Calculate initial EMI
        --
        -- EMI =
        -- P * r * (1+r)^n
        -- ----------------
        -- (1+r)^n - 1
        -- ====================================================

        v_emi :=
            (
                v_approved_loan
                * v_monthly_rate
                * POWER(1 + v_monthly_rate, v_months)
            ) / (
                POWER(1 + v_monthly_rate, v_months) - 1
            );

        v_emi := ROUND(v_emi, 2);


        -- ====================================================
        -- STEP 7: Calculate total monthly EMI
        --
        -- Existing EMI + New Loan EMI
        -- ====================================================

        v_total_emi :=
            v_existing_emi + v_emi;


        -- ====================================================
        -- STEP 8: WHILE LOOP
        --
        -- If total EMI exceeds FOIR:
        --
        -- 1. Reduce loan by Rs.10,000.
        -- 2. Recalculate EMI.
        -- 3. Check FOIR again.
        -- 4. Continue until affordable.
        -- ====================================================

        WHILE v_total_emi > v_foir
              AND v_approved_loan > 0
        LOOP

            v_approved_loan :=
                v_approved_loan - 10000;

            v_count :=
                v_count + 1;


            -- ------------------------------------------------
            -- Recalculate EMI after reducing loan.
            -- ------------------------------------------------

            IF v_approved_loan > 0 THEN

                v_emi :=
                    (
                        v_approved_loan
                        * v_monthly_rate
                        * POWER(
                            1 + v_monthly_rate,
                            v_months
                        )
                    ) / (
                        POWER(
                            1 + v_monthly_rate,
                            v_months
                        ) - 1
                    );

                v_emi := ROUND(v_emi, 2);

                v_total_emi :=
                    v_existing_emi + v_emi;

            ELSE

                v_emi := 0;

                v_total_emi :=
                    v_existing_emi;

            END IF;

        END LOOP;


        -- ----------------------------------------------------
        -- Store final EMI.
        -- ----------------------------------------------------

        v_approved_emi :=
            v_emi;

    END IF;


    -- ========================================================
    -- STEP 9: CASE DECISION
    --
    -- APPROVED:
    -- Requested loan is affordable.
    --
    -- CONDITIONAL:
    -- Loan was reduced to make it affordable.
    --
    -- REJECTED:
    -- No eligible loan remains.
    -- ========================================================

    v_decision :=
        CASE

            WHEN v_approved_loan = 0 THEN
                'REJECTED'

            WHEN v_approved_loan = v_loan
                 AND v_total_emi <= v_foir THEN
                'APPROVED'

            WHEN v_approved_loan < v_loan
                 AND v_total_emi <= v_foir THEN
                'CONDITIONAL'

            ELSE
                'REJECTED'

        END;


    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        '       LOAN EMI AFFORDABILITY CHECKER'
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        'Applicant        : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No          : ' || v_roll
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Monthly Salary   : Rs.' || v_salary
    );

    DBMS_OUTPUT.PUT_LINE(
        'Existing EMI     : Rs.' || v_existing_emi
    );

    DBMS_OUTPUT.PUT_LINE(
        'Requested Loan   : Rs.' || v_loan
    );

    DBMS_OUTPUT.PUT_LINE(
        'Interest Rate    : ' || v_rate || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Tenure           : ' || v_months || ' months'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'FOIR Limit       : Rs.' || ROUND(v_foir, 2)
    );

    DBMS_OUTPUT.PUT_LINE(
        'Maximum Loan     : Rs.' || v_max_loan
    );

    DBMS_OUTPUT.PUT_LINE(
        'Calculated EMI   : Rs.' || v_emi
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total EMI        : Rs.' || ROUND(v_total_emi, 2)
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Approved Loan    : Rs.' || v_approved_loan
    );

    DBMS_OUTPUT.PUT_LINE(
        'Approved EMI     : Rs.' || v_approved_emi
    );

    DBMS_OUTPUT.PUT_LINE(
        'Adjustments      : ' || v_count
    );

    DBMS_OUTPUT.PUT_LINE(
        'Decision         : ' || v_decision
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

END;
/