SET SERVEROUTPUT ON;

-- ============================================================
-- P1.3 - Constants, NULL and NVL
--
-- Question:
-- Part A:
-- 1. Declare a GST constant of 18%.
-- 2. Calculate CGST = 9% and SGST = 9% on the base price.
-- 3. Print base price, CGST, SGST and total amount.
--
-- Part B:
-- 1. Declare v_city as NULL.
-- 2. Use NVL to replace NULL with "Ahmedabad".
-- 3. Use NVL2 to check whether the city is NULL or not.
-- 4. Clearly show the difference between NVL and NVL2.
--
-- Key points:
-- 1. CONSTANT cannot be changed after declaration.
-- 2. NULL means that no value is currently stored.
-- 3. NVL(value, replacement) returns the replacement when
--    value is NULL.
-- 4. NVL2(value, value_if_not_null, value_if_null) checks
--    whether a value is NULL.
-- 5. Roll-number formula:
--       base_price = roll_no * 500 + 1000
--
-- Personalised details:
-- Name    : Nirav Vala
-- Roll No : 33
-- Base    : 33 * 500 + 1000 = 17500
-- ============================================================

DECLARE
    -- GST rate is fixed, so it is declared as a CONSTANT.
    c_gst_rate CONSTANT NUMBER := 18;

    v_base_price NUMBER;
    v_cgst       NUMBER;
    v_sgst       NUMBER;
    v_total      NUMBER;

    -- City is intentionally NULL to demonstrate NVL and NVL2.
    v_city VARCHAR2(50) := NULL;

    v_nvl_city VARCHAR2(50);
BEGIN
    -- Calculate base price using the assignment's roll-number formula.
    v_base_price := 50 * 500 + 1000;

    -- GST is divided equally into CGST and SGST.
    v_cgst := v_base_price * 9 / 100;
    v_sgst := v_base_price * 9 / 100;

    -- Total = Base Price + CGST + SGST
    v_total := v_base_price + v_cgst + v_sgst;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('          GST CALCULATION');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Name       : Nikhil tak');
    DBMS_OUTPUT.PUT_LINE('Roll No    : 50');
    DBMS_OUTPUT.PUT_LINE('GST Rate   : ' || c_gst_rate || '%');
    DBMS_OUTPUT.PUT_LINE('Base Price : Rs.' || TO_CHAR(v_base_price, '99,999.00'));
    DBMS_OUTPUT.PUT_LINE('CGST @ 9%  : Rs.' || TO_CHAR(v_cgst, '99,999.00'));
    DBMS_OUTPUT.PUT_LINE('SGST @ 9%  : Rs.' || TO_CHAR(v_sgst, '99,999.00'));
    DBMS_OUTPUT.PUT_LINE('Total      : Rs.' || TO_CHAR(v_total, '99,999.00'));

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('          NULL / NVL / NVL2');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');

    -- NVL replaces NULL with the supplied replacement value.
    v_nvl_city := NVL(v_city, 'Ahmedabad');

    DBMS_OUTPUT.PUT_LINE('Original City : NULL');
    DBMS_OUTPUT.PUT_LINE('Using NVL     : ' || v_nvl_city);

    -- NVL2 checks whether v_city contains a value.
    -- Since v_city is NULL, the third argument is returned.
    DBMS_OUTPUT.PUT_LINE(
        'Using NVL2    : ' ||
        NVL2(v_city,
             'City Known: ' || v_city,
             'City Unknown')
    );

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
END;
/