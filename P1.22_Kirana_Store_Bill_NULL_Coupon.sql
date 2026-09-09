SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.22 - Kirana Store Bill with NULL Coupon
--
-- Question:
-- Create a kirana store bill.
--
-- Calculate:
--   gross     = qty * price
--   discount  = gross * NVL(coupon, 0) / 100
--   taxable   = gross - discount
--   CGST      = 9% of taxable
--   SGST      = 9% of taxable
--   final     = ROUND(taxable * 1.18)
--
-- Requirements:
-- 1. Coupon variable may be NULL.
-- 2. Use NVL(v_coupon, 0) for discount calculation.
-- 3. Use NVL2() in the output:
--       Coupon applied: [x]%
--       OR
--       No coupon
-- 4. Use a CONSTANT for the GST rate.
-- 5. Use TO_CHAR() for formatted amounts.
-- 6. ROUND final bill to the nearest rupee.
-- 7. Run the block twice:
--       Test 1 -> coupon = NULL
--       Test 2 -> coupon = 10
--
-- Key points:
-- 1. NVL(value, replacement) replaces NULL with a value.
-- 2. NVL2(value, if_not_null, if_null) chooses between
--    two output values.
-- 3. NULL coupon means no discount.
-- 4. CGST and SGST are both 9%.
-- 5. Total GST is therefore 18%.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Roll-number formulas:
-- Quantity = roll_no MOD 5 + 2
--          = 50 MOD 5 + 2
--          = 5
--
-- Price = roll_no * 100 + 400
--       = 50 * 100 + 400
--       = Rs.3,700
-- ============================================================

DECLARE
    -- --------------------------------------------------------
    -- Personalised input values.
    -- --------------------------------------------------------

    v_qty NUMBER := MOD(50, 5) + 2;

    v_price NUMBER := 33 * 100 + 400;


    -- --------------------------------------------------------
    -- Coupon:
    --
    -- TEST 1:
    -- NULL = no coupon
    --
    -- For TEST 2, change NULL to 10.
    -- --------------------------------------------------------

    v_coupon NUMBER := NULL;


    -- --------------------------------------------------------
    -- GST rate is fixed.
    -- --------------------------------------------------------

    c_gst_rate CONSTANT NUMBER := 18;


    -- --------------------------------------------------------
    -- Bill calculation variables.
    -- --------------------------------------------------------

    v_gross    NUMBER;
    v_discount NUMBER;
    v_taxable  NUMBER;
    v_cgst     NUMBER;
    v_sgst     NUMBER;
    v_total    NUMBER;

BEGIN

    -- ========================================================
    -- CALCULATE GROSS AMOUNT
    -- ========================================================

    v_gross := v_qty * v_price;


    -- ========================================================
    -- CALCULATE DISCOUNT
    --
    -- NVL(v_coupon, 0):
    --
    -- NULL coupon -> 0%
    -- 10 coupon   -> 10%
    -- ========================================================

    v_discount :=
        v_gross * NVL(v_coupon, 0) / 100;


    -- ========================================================
    -- TAXABLE AMOUNT
    -- ========================================================

    v_taxable :=
        v_gross - v_discount;


    -- ========================================================
    -- GST CALCULATION
    --
    -- CGST = 9%
    -- SGST = 9%
    -- ========================================================

    v_cgst :=
        v_taxable * (c_gst_rate / 2) / 100;

    v_sgst :=
        v_taxable * (c_gst_rate / 2) / 100;


    -- ========================================================
    -- FINAL TOTAL
    --
    -- ROUND() rounds the bill to the nearest rupee.
    -- ========================================================

    v_total :=
        ROUND(v_taxable + v_cgst + v_sgst);


    -- ========================================================
    -- PRINT BILL
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('             KIRANA STORE BILL', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Customer Name', 24) ||
        ': ' ||
        RPAD('Nikhil tak', 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Roll No', 24) ||
        ': ' ||
        RPAD('50', 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Quantity', 24) ||
        ': ' ||
        LPAD(v_qty, 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Price / Item', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_price, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Gross Amount', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_gross, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    -- --------------------------------------------------------
    -- NVL2 demonstrates whether the coupon is NULL or not.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Coupon', 24) ||
        ': ' ||
        RPAD(
            NVL2(
                v_coupon,
                'Coupon applied: ' ||
                v_coupon || '%',
                'No coupon'
            ),
            21
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Discount', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_discount, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Taxable Amount', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_taxable, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('CGST @ 9%', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_cgst, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('SGST @ 9%', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_sgst, 'FM99,99,999.00'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('FINAL TOTAL', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_total, 'FM99,99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

END;
/