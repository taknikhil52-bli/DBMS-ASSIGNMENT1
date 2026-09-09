SET SERVEROUTPUT ON;

-- ============================================================
-- P1.10 - Temperature Converter
--
-- Question:
-- 1. Declare v_celsius NUMBER.
-- 2. Convert Celsius to Fahrenheit:
--       F = C * 9 / 5 + 32
-- 3. Convert Celsius to Kelvin:
--       K = C + 273.15
-- 4. Round Fahrenheit to 1 decimal place.
-- 5. Take 98.6 Fahrenheit and convert it back to Celsius.
-- 6. Observe operator precedence:
--       C * 9 / 5 + 32
--       C * (9 / 5) + 32
--    Both give the same mathematical result in Oracle because
--    multiplication and division have the same precedence and
--    are evaluated from left to right.
--
-- Key points:
-- 1. Use arithmetic operators for conversion.
-- 2. ROUND(value, 1) keeps one decimal place.
-- 3. MOD() is used to generate the personalised Celsius value.
-- 4. Roll-number formula:
--       Celsius = roll_no MOD 20 + 25
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Celsius:
-- 50 MOD 20 + 25 = 38
-- ============================================================

DECLARE
    v_celsius NUMBER;
    v_fahrenheit NUMBER;
    v_kelvin NUMBER;

    v_fahrenheit_input NUMBER := 98.6;
    v_celsius_reverse NUMBER;

    v_fahrenheit_check NUMBER;
BEGIN

    -- --------------------------------------------------------
    -- Generate Celsius using the assignment's roll-number
    -- formula.
    -- --------------------------------------------------------

    v_celsius := MOD(33, 20) + 25;


    -- --------------------------------------------------------
    -- Celsius to Fahrenheit
    --
    -- F = C * 9 / 5 + 32
    -- --------------------------------------------------------

    v_fahrenheit := ROUND(
        v_celsius * 9 / 5 + 32,
        1
    );


    -- --------------------------------------------------------
    -- Celsius to Kelvin
    --
    -- K = C + 273.15
    -- --------------------------------------------------------

    v_kelvin := v_celsius + 273.15;


    -- --------------------------------------------------------
    -- Reverse conversion:
    --
    -- C = (F - 32) * 5 / 9
    --
    -- Using 98.6 Fahrenheit should give approximately 37 C.
    -- --------------------------------------------------------

    v_celsius_reverse := ROUND(
        (v_fahrenheit_input - 32) * 5 / 9,
        1
    );


    -- --------------------------------------------------------
    -- Operator precedence demonstration.
    --
    -- Both expressions are equivalent:
    --
    -- C * 9 / 5 + 32
    -- C * (9 / 5) + 32
    --
    -- Multiplication and division have equal precedence.
    -- They are evaluated from left to right.
    -- --------------------------------------------------------

    v_fahrenheit_check := ROUND(
        v_celsius * (9 / 5) + 32,
        1
    );


    -- --------------------------------------------------------
    -- Display results.
    -- --------------------------------------------------------

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('         TEMPERATURE CONVERTER');
    DBMS_OUTPUT.PUT_LINE('========================================');

    DBMS_OUTPUT.PUT_LINE(
        'Name      : Nirav Vala'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Roll No   : 33'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Celsius    : ' ||
        TO_CHAR(v_celsius, 'FM990.0') || ' C'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Fahrenheit : ' ||
        TO_CHAR(v_fahrenheit, 'FM990.0') || ' F'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Kelvin     : ' ||
        TO_CHAR(v_kelvin, 'FM990.00') || ' K'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        '98.6 F to Celsius : ' ||
        TO_CHAR(v_celsius_reverse, 'FM990.0') || ' C'
    );

    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Fahrenheit using C * 9 / 5 + 32 : ' ||
        TO_CHAR(v_fahrenheit, 'FM990.0')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Fahrenheit using C * (9 / 5) + 32 : ' ||
        TO_CHAR(v_fahrenheit_check, 'FM990.0')
    );

    DBMS_OUTPUT.PUT_LINE(
        'Result: Both expressions give the same value.'
    );

    DBMS_OUTPUT.PUT_LINE('========================================');

END;
/