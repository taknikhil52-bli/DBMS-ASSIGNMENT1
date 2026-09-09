SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.2 - INDIAN INCOME TAX CALCULATOR 2024-25
--
-- Question:
-- Build an Indian Income Tax Calculator for the
-- New Tax Regime 2024-25.
--
-- Requirements:
-- 1. Deduct standard deduction of Rs.75,000 first.
--
-- 2. Tax slabs:
--       0 - 3L     = NIL
--       3 - 7L     = 5%
--       7 - 10L    = 10%
--       10 - 12L   = 15%
--       12 - 15L   = 20%
--       Above 15L  = 30%
--
-- 3. Calculate:
--       Gross salary
--       Taxable income
--       Total tax
--       Monthly TDS
--       Monthly take-home salary
--
-- 4. Use a SEARCHED CASE statement for tax slabs.
--    Do NOT use IF-ELSIF for the tax slabs.
--
-- 5. If tax = 0, print:
--       No tax this year — save more with PPF/ELSS!
--
-- Key points:
-- 1. Standard deduction is removed before tax calculation.
-- 2. Tax is calculated progressively across slabs.
-- 3. CASE is used to determine the applicable slab/rate.
-- 4. Monthly TDS = Annual Tax / 12.
-- 5. Monthly salary = Gross Salary / 12.
-- 6. Monthly take-home = Monthly Salary - Monthly TDS.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Gross salary seed used for this practical:
-- Gross = roll_no * 25,000 + 2,50,000
--       = 33 * 25,000 + 2,50,000
--       = Rs.10,75,000
--
-- Standard deduction:
-- Rs.75,000
--
-- Taxable income:
-- Rs.10,75,000 - Rs.75,000
-- = Rs.10,00,000
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- Salary values
    -- --------------------------------------------------------

    v_gross_salary NUMBER;
    v_standard_deduction CONSTANT NUMBER := 75000;

    v_taxable_income NUMBER;

    v_tax NUMBER := 0;

    v_monthly_tds NUMBER;
    v_monthly_salary NUMBER;
    v_take_home NUMBER;


    -- --------------------------------------------------------
    -- Variables used for slab calculation.
    -- --------------------------------------------------------

    v_remaining NUMBER;

    v_tax_slab NUMBER;

    v_slab_name VARCHAR2(50);

BEGIN

    -- ========================================================
    -- STEP 1: Calculate gross salary.
    -- ========================================================

    v_gross_salary :=
        v_roll * 25000 + 250000;


    -- ========================================================
    -- STEP 2: Apply standard deduction.
    -- ========================================================

    v_taxable_income :=
        v_gross_salary - v_standard_deduction;


    -- ========================================================
    -- STEP 3: Progressive tax calculation.
    --
    -- The assignment requires a SEARCHED CASE statement.
    --
    -- Each CASE condition determines how much income belongs
    -- to the current slab.
    -- ========================================================

    v_remaining := v_taxable_income;


    -- --------------------------------------------------------
    -- Slab 1: 0 - 3,00,000
    -- Tax = NIL
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining <= 300000 THEN
                0
            ELSE
                0
        END;

    v_tax := v_tax + v_tax_slab;

    IF v_remaining > 300000 THEN
        v_remaining := v_remaining - 300000;
    ELSE
        v_remaining := 0;
    END IF;


    -- --------------------------------------------------------
    -- Slab 2: 3,00,001 - 7,00,000
    -- Rate = 5%
    -- Maximum slab amount = 4,00,000
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining <= 400000 THEN
                v_remaining * 0.05
            ELSE
                400000 * 0.05
        END;

    v_tax := v_tax + v_tax_slab;

    IF v_remaining > 400000 THEN
        v_remaining := v_remaining - 400000;
    ELSE
        v_remaining := 0;
    END IF;


    -- --------------------------------------------------------
    -- Slab 3: 7,00,001 - 10,00,000
    -- Rate = 10%
    -- Maximum slab amount = 3,00,000
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining <= 300000 THEN
                v_remaining * 0.10
            ELSE
                300000 * 0.10
        END;

    v_tax := v_tax + v_tax_slab;

    IF v_remaining > 300000 THEN
        v_remaining := v_remaining - 300000;
    ELSE
        v_remaining := 0;
    END IF;


    -- --------------------------------------------------------
    -- Slab 4: 10,00,001 - 12,00,000
    -- Rate = 15%
    -- Maximum slab amount = 2,00,000
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining <= 200000 THEN
                v_remaining * 0.15
            ELSE
                200000 * 0.15
        END;

    v_tax := v_tax + v_tax_slab;

    IF v_remaining > 200000 THEN
        v_remaining := v_remaining - 200000;
    ELSE
        v_remaining := 0;
    END IF;


    -- --------------------------------------------------------
    -- Slab 5: 12,00,001 - 15,00,000
    -- Rate = 20%
    -- Maximum slab amount = 3,00,000
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining <= 300000 THEN
                v_remaining * 0.20
            ELSE
                300000 * 0.20
        END;

    v_tax := v_tax + v_tax_slab;

    IF v_remaining > 300000 THEN
        v_remaining := v_remaining - 300000;
    ELSE
        v_remaining := 0;
    END IF;


    -- --------------------------------------------------------
    -- Slab 6: Above 15,00,000
    -- Rate = 30%
    -- --------------------------------------------------------

    v_tax_slab :=
        CASE
            WHEN v_remaining > 0 THEN
                v_remaining * 0.30
            ELSE
                0
        END;

    v_tax := v_tax + v_tax_slab;


    -- ========================================================
    -- STEP 4: Round annual tax.
    -- ========================================================

    v_tax := ROUND(v_tax);


    -- ========================================================
    -- STEP 5: Calculate monthly TDS.
    -- ========================================================

    v_monthly_tds :=
        ROUND(v_tax / 12, 2);


    -- ========================================================
    -- STEP 6: Calculate monthly gross salary.
    -- ========================================================

    v_monthly_salary :=
        ROUND(v_gross_salary / 12, 2);


    -- ========================================================
    -- STEP 7: Calculate monthly take-home salary.
    -- ========================================================

    v_take_home :=
        v_monthly_salary - v_monthly_tds;


    -- ========================================================
    -- STEP 8: Determine applicable slab for display.
    --
    -- This is also done using a SEARCHED CASE statement.
    -- ========================================================

    v_slab_name :=
        CASE
            WHEN v_taxable_income <= 300000 THEN
                '0 - 3 Lakh (NIL)'

            WHEN v_taxable_income <= 700000 THEN
                '3 - 7 Lakh (5%)'

            WHEN v_taxable_income <= 1000000 THEN
                '7 - 10 Lakh (10%)'

            WHEN v_taxable_income <= 1200000 THEN
                '10 - 12 Lakh (15%)'

            WHEN v_taxable_income <= 1500000 THEN
                '12 - 15 Lakh (20%)'

            ELSE
                'Above 15 Lakh (30%)'
        END;


    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        '          INDIAN INCOME TAX CALCULATOR'
    );

    DBMS_OUTPUT.PUT_LINE(
        '              NEW TAX REGIME 2024-25'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Name                : ' || v_name
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No             : ' || v_roll
    );

    DBMS_OUTPUT.PUT_LINE(
        '------------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Gross Salary        : Rs.' ||
        TO_CHAR(v_gross_salary, 'FM99,99,999')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Standard Deduction  : Rs.' ||
        TO_CHAR(v_standard_deduction, 'FM99,99,999')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Taxable Income      : Rs.' ||
        TO_CHAR(v_taxable_income, 'FM99,99,999')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Applicable Slab     : ' ||
        v_slab_name
    );

    DBMS_OUTPUT.PUT_LINE(
        '------------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Annual Tax          : Rs.' ||
        TO_CHAR(v_tax, 'FM99,99,999')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Monthly TDS         : Rs.' ||
        TO_CHAR(v_monthly_tds, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Monthly Salary      : Rs.' ||
        TO_CHAR(v_monthly_salary, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Monthly Take-Home   : Rs.' ||
        TO_CHAR(v_take_home, 'FM99,999.00')
    );


    -- ========================================================
    -- ZERO-TAX MESSAGE
    -- ========================================================

    IF v_tax = 0 THEN

        DBMS_OUTPUT.PUT_LINE(
            'No tax this year - save more with PPF/ELSS!'
        );

    END IF;


    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

END;
/