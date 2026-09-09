SET SERVEROUTPUT ON;

-- ============================================================
-- P1.6 - Bank Interest Calculator - SI and CI
--
-- Question:
-- Build a bank interest calculator.
--
-- Calculate:
-- 1. Simple Interest (SI)
--       SI = P * R * T / 100
--
-- 2. Compound Interest (CI)
--       CI = P * (1 + R/100)^T - P
--
-- 3. Final amount for SI and CI.
-- 4. Difference between SI and CI.
-- 5. Difference percentage.
-- 6. If CI is more than SI by 10%, print:
--       "Tip: FD is better than savings account for this amount."
--
-- Use POWER() for compound interest.
-- Use TO_CHAR() to format monetary values.
--
-- Key points:
-- 1. POWER(base, exponent) is used for powers.
-- 2. SI is calculated directly using multiplication.
-- 3. CI uses compound growth for every year.
-- 4. Final SI Amount = Principal + SI.
-- 5. Final CI Amount = Principal + CI.
--
-- Personalised details:
-- Name         : Nikhil tak
-- Roll No      : 50
-- Birth Month  : 10 (October)
--
-- Assignment formulas:
-- Principal = roll_no * 1000
--           = 50 * 1000
--           = Rs.50,000
--
-- Rate = birth_month * 0.5 + 4
--      = 11 * 0.5 + 4
--      = 9.5%
--
-- Years = 3
-- ============================================================

DECLARE
    v_principal NUMBER;
    v_rate      NUMBER;
    v_years     NUMBER;

    v_si        NUMBER;
    v_ci        NUMBER;

    v_si_amount NUMBER;
    v_ci_amount NUMBER;

    v_difference NUMBER;
    v_diff_pct   NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Personalised input based on roll number and birth month.
    -- --------------------------------------------------------

    v_principal := 50 * 1000;
    v_rate := 11 * 0.5 + 4;
    v_years := 3;


    -- --------------------------------------------------------
    -- Simple Interest
    --
    -- SI = P * R * T / 100
    -- --------------------------------------------------------

    v_si := v_principal * v_rate * v_years / 100;


    -- --------------------------------------------------------
    -- Compound Interest
    --
    -- CI = P * (1 + R/100)^T - P
    --
    -- POWER() is used to calculate the power.
    -- --------------------------------------------------------

    v_ci := v_principal *
            POWER(1 + v_rate / 100, v_years)
            - v_principal;


    -- --------------------------------------------------------
    -- Calculate final amounts.
    -- --------------------------------------------------------

    v_si_amount := v_principal + v_si;
    v_ci_amount := v_principal + v_ci;


    -- --------------------------------------------------------
    -- Compare SI and CI.
    -- --------------------------------------------------------

    v_difference := v_ci - v_si;

    v_diff_pct := (v_difference / v_si) * 100;


    -- --------------------------------------------------------
    -- Display the result.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('       BANK INTEREST CALCULATOR');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE('Name        : Nikhil tak');
    DBMS_OUTPUT.PUT_LINE('Roll No     : 50');
    DBMS_OUTPUT.PUT_LINE('Birth Month : November');

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Principal   : Rs.' ||
        TO_CHAR(v_principal, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Rate        : ' || v_rate || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Time        : ' || v_years || ' years'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Simple Interest : Rs.' ||
        TO_CHAR(v_si, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'SI Final Amount : Rs.' ||
        TO_CHAR(v_si_amount, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Compound Interest : Rs.' ||
        TO_CHAR(v_ci, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'CI Final Amount : Rs.' ||
        TO_CHAR(v_ci_amount, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'CI - SI Difference : Rs.' ||
        TO_CHAR(v_difference, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Difference %       : ' ||
        TO_CHAR(v_diff_pct, 'FM990.00') || '%'
    );


    -- --------------------------------------------------------
    -- Assignment condition:
    -- If CI is more than SI by more than 10%, display the tip.
    -- --------------------------------------------------------

    IF v_diff_pct > 10 THEN
        DBMS_OUTPUT.PUT_LINE(
            'Tip: FD is better than savings account for this amount.'
        );
    END IF;

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/