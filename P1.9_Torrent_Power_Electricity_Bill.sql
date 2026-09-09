SET SERVEROUTPUT ON;

-- ============================================================
-- P1.9 - Torrent Power Electricity Bill
--
-- Question:
-- Build a simple electricity bill for Torrent Power.
--
-- Requirements:
-- 1. Declare v_units NUMBER.
-- 2. Declare c_rate CONSTANT NUMBER := 5.
-- 3. Declare c_fixed CONSTANT NUMBER := 70.
-- 4. Calculate energy charge = units * rate.
-- 5. Calculate total = energy charge + fixed charge.
-- 6. Print a mini bill using DBMS_OUTPUT.PUT_LINE().
--
-- Key points:
-- 1. CONSTANT is used for values that do not change.
-- 2. Multiplication calculates the energy charge.
-- 3. Addition calculates the final bill.
-- 4. Concatenation (||) joins text with values.
-- 5. Roll-number seed:
--       units = roll_no * 10 + 50
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Units:
-- 33 * 10 + 50 = 380 units
-- ============================================================

DECLARE
    v_units        NUMBER;
    c_rate         CONSTANT NUMBER := 5;
    c_fixed        CONSTANT NUMBER := 70;

    v_energy_charge NUMBER;
    v_total         NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Calculate units using the assignment's roll-number
    -- formula.
    -- --------------------------------------------------------

    v_units := 33 * 10 + 50;


    -- --------------------------------------------------------
    -- Energy charge:
    -- Units consumed * Rate per unit
    --
    -- 380 * 5 = Rs.1900
    -- --------------------------------------------------------

    v_energy_charge := v_units * c_rate;


    -- --------------------------------------------------------
    -- Final bill:
    -- Energy charge + Fixed monthly charge
    --
    -- 1900 + 70 = Rs.1970
    -- --------------------------------------------------------

    v_total := v_energy_charge + c_fixed;


    -- --------------------------------------------------------
    -- Display the electricity bill.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('          TORRENT POWER BILL');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Consumer Name : Nikhil tak'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No       : 50'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Units Consumed: ' || v_units
    );

    DBMS_OUTPUT.PUT_LINE(
        'Energy Charge : Rs.' ||
        TO_CHAR(v_energy_charge, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Fixed Charge  : Rs.' ||
        TO_CHAR(c_fixed, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Total Bill    : Rs.' ||
        TO_CHAR(v_total, 'FM99,999.00')
    );

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/