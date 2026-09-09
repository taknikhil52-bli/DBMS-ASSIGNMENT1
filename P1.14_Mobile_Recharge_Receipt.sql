SET SERVEROUTPUT ON;

-- ============================================================
-- P1.14 - Mobile Recharge Receipt
--
-- Question:
-- Build a Jio/Airtel style mobile recharge receipt.
--
-- Requirements:
-- 1. Declare c_gst CONSTANT NUMBER := 18.
-- 2. Select a plan price from:
--       199, 299, 399, 599
--    using:
--       index = roll_no MOD 4 + 1
-- 3. Calculate GST amount.
-- 4. Calculate total payable.
-- 5. Display a formatted receipt using RPAD.
-- 6. Format amounts using:
--       TO_CHAR(value, '99,999.99')
-- 7. Calculate validity date:
--       SYSDATE + 28
--
-- Key points:
-- 1. CONSTANT stores a fixed GST rate.
-- 2. MOD() is used to generate the plan index.
-- 3. CASE is used to select the corresponding plan price.
-- 4. GST = Plan Price * 18 / 100.
-- 5. Total = Plan Price + GST.
-- 6. SYSDATE + 28 gives a date 28 days from today.
-- 7. RPAD() helps align the receipt labels.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50 
--
-- Plan index:
-- 50 MOD 4 + 1
-- = 1 + 1
-- = 2
--
-- Therefore, selected plan = Rs.299
-- ============================================================

DECLARE
    c_gst CONSTANT NUMBER := 18;

    v_roll       NUMBER := 33;
    v_plan_index NUMBER;
    v_plan       NUMBER;

    v_gst        NUMBER;
    v_total      NUMBER;

    v_validity   DATE;
BEGIN

    -- --------------------------------------------------------
    -- Calculate plan index from the roll number.
    -- --------------------------------------------------------

    v_plan_index := MOD(v_roll, 4) + 1;


    -- --------------------------------------------------------
    -- Select the plan price.
    --
    -- Index 1 -> Rs.199
    -- Index 2 -> Rs.299
    -- Index 3 -> Rs.399
    -- Index 4 -> Rs.599
    -- --------------------------------------------------------

    v_plan :=
        CASE v_plan_index
            WHEN 1 THEN 199
            WHEN 2 THEN 299
            WHEN 3 THEN 399
            WHEN 4 THEN 599
        END;


    -- --------------------------------------------------------
    -- Calculate GST and final amount.
    -- --------------------------------------------------------

    v_gst := v_plan * c_gst / 100;

    v_total := v_plan + v_gst;


    -- --------------------------------------------------------
    -- Validity is 28 days from the current date.
    -- --------------------------------------------------------

    v_validity := SYSDATE + 28;


    -- --------------------------------------------------------
    -- Display recharge receipt.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('       MOBILE RECHARGE RECEIPT', 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Customer : Nikhil tak', 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Roll No  : 50', 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Plan     : Rs.' ||
                  TO_CHAR(v_plan, 'FM99,999.00'), 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('GST @ 18%: Rs.' ||
                  TO_CHAR(v_gst, 'FM99,999.00'), 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD('Total    : Rs.' ||
                  TO_CHAR(v_total, 'FM99,999.00'), 42) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' || RPAD(
            'Valid Till: ' ||
            TO_CHAR(v_validity, 'DD-MON-YYYY'),
            42
        ) || '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------+'
    );

END;
/