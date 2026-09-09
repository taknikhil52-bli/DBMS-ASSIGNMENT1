SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.17 - Home Loan EMI Calculator
--
-- Question:
-- Build an SBI home loan EMI calculator.
--
-- Given:
--   Principal       = roll_no * 10000 + 50000
--   Annual Rate     = 9%
--   Loan Period     = 5 years
--
-- Calculate:
--   1. Monthly interest rate
--   2. Number of monthly installments
--   3. Monthly EMI
--   4. Total payment
--   5. Total interest
--   6. Percentage of total payment that is interest
--
-- EMI Formula:
--
--       P * r * POWER(1+r,n)
-- EMI = -------------------------
--       POWER(1+r,n) - 1
--
-- Key points:
-- 1. POWER() is used for exponent calculation.
-- 2. Annual rate is converted into a monthly rate.
-- 3. Years are converted into months.
-- 4. ROUND() keeps the EMI to two decimal places.
-- 5. Total Payment = EMI * Number of Months.
-- 6. Total Interest = Total Payment - Principal.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Principal:
-- 50* 10000 + 50000 = Rs.380000
-- ============================================================

DECLARE
    v_principal      NUMBER;
    v_annual_rate    NUMBER := 9;
    v_years          NUMBER := 5;
    v_monthly_rate   NUMBER;
    v_months         NUMBER;
    v_emi            NUMBER;
    v_total_payment  NUMBER;
    v_total_interest NUMBER;
    v_interest_pct   NUMBER;
BEGIN
    -- Calculate principal using the assignment formula.
    v_principal := 50 * 10000 + 50000;

    -- Convert annual interest rate into monthly rate.
    -- 9 / 12 / 100 = 0.0075
    v_monthly_rate := v_annual_rate / 12 / 100;

    -- Convert years into months.
    -- 5 * 12 = 60 months.
    v_months := v_years * 12;

    -- Calculate monthly EMI.
    v_emi := ROUND(
        v_principal
        * v_monthly_rate
        * POWER(1 + v_monthly_rate, v_months)
        / (POWER(1 + v_monthly_rate, v_months) - 1),
        2
    );

    -- Calculate total payment.
    v_total_payment := ROUND(v_emi * v_months, 2);

    -- Calculate total interest.
    v_total_interest := v_total_payment - v_principal;

    -- Calculate percentage of total payment that is interest.
    v_interest_pct := ROUND(
        (v_total_interest / v_total_payment) * 100,
        2
    );

    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('         HOME LOAN EMI CALCULATOR');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE('Name             : Nikhil tak');
    DBMS_OUTPUT.PUT_LINE('Roll No          : 50');

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Principal        : Rs.' ||
        TO_CHAR(v_principal, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Annual Rate      : ' ||
        v_annual_rate || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Loan Period      : ' ||
        v_years || ' years'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Monthly Rate     : ' ||
        TO_CHAR(v_monthly_rate * 100, 'FM990.0000') || '%'
    );

    DBMS_OUTPUT.PUT_LINE(
        'No. of Months    : ' ||
        v_months
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Monthly EMI      : Rs.' ||
        TO_CHAR(v_emi, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total Payment    : Rs.' ||
        TO_CHAR(v_total_payment, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total Interest   : Rs.' ||
        TO_CHAR(v_total_interest, 'FM99,99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Interest %       : ' ||
        TO_CHAR(v_interest_pct, 'FM990.00') || '%'
    );

    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/