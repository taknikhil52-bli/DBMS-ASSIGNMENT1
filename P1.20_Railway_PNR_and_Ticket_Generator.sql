SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P1.20 - Railway PNR and Ticket Generator
--
-- Question:
-- Build an IRCTC-style railway ticket generator.
--
-- Inputs:
--   Passenger name
--   Date of birth
--   Roll number
--
-- Requirements:
-- 1. Generate PNR:
--      'GJ' || TO_CHAR(SYSDATE,'YYMM') || LPAD(roll_no,4,'0')
--
-- 2. Journey date:
--      SYSDATE + (roll_no MOD 30 + 1)
--
-- 3. Base fare:
--      roll_no * 50 + 200
--
-- 4. Calculate age using:
--      TRUNC(MONTHS_BETWEEN(SYSDATE, dob)/12)
--
-- 5. Senior citizens aged 60 or above get 40% concession.
--
-- 6. Print the complete ticket using RPAD/LPAD.
--
-- 7. Test the program with:
--      a) Your own DOB
--      b) 01-JAN-1960
--         to demonstrate senior concession.
--
-- Key points:
-- 1. LPAD is used to create a fixed-width roll number in PNR.
-- 2. TO_CHAR formats dates.
-- 3. SYSDATE + number adds days to a date.
-- 4. MONTHS_BETWEEN calculates the age.
-- 5. CASE is used for senior-citizen concession logic.
-- 6. RPAD/LPAD align the printed ticket.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- Roll-number calculations:
--
-- Journey days:
-- 50 MOD 30 + 1 = 4 days
--
-- Base fare:
-- 50 * 50 + 200 = Rs.1,850
--
-- NOTE:
-- Replace the temporary DOB below with your actual DOB
-- before taking the final submission screenshot.
-- ============================================================

DECLARE
    v_name VARCHAR2(100) := 'Nikhil tak';

    v_roll NUMBER := 50;

    -- --------------------------------------------------------
    -- TEMPORARY DOB
    --
    -- Replace this with your actual DOB.
    -- --------------------------------------------------------

    v_dob DATE := DATE '2007-10-15';

    v_pnr          VARCHAR2(30);
    v_journey_date DATE;

    v_base_fare    NUMBER;
    v_age          NUMBER;

    v_discount     NUMBER;
    v_final_fare   NUMBER;

    v_status       VARCHAR2(30);
BEGIN

    -- --------------------------------------------------------
    -- Generate PNR.
    --
    -- Format:
    -- GJ + YYMM + 4-digit roll number
    --
    -- For roll 33:
    -- LPAD(33, 4, '0') = 0033
    -- --------------------------------------------------------

    v_pnr :=
        'GJ' ||
        TO_CHAR(SYSDATE, 'YYMM') ||
        LPAD(v_roll, 4, '0');


    -- --------------------------------------------------------
    -- Calculate journey date.
    --
    -- 50 MOD 30 + 1 = 4 days.
    -- --------------------------------------------------------

    v_journey_date :=
        SYSDATE + (MOD(v_roll, 30) + 1);


    -- --------------------------------------------------------
    -- Calculate base fare.
    --
    -- 50 * 50 + 200 = Rs.1850
    -- --------------------------------------------------------

    v_base_fare :=
        v_roll * 50 + 200;


    -- --------------------------------------------------------
    -- Calculate passenger age.
    -- --------------------------------------------------------

    v_age :=
        TRUNC(
            MONTHS_BETWEEN(SYSDATE, v_dob) / 12
        );


    -- --------------------------------------------------------
    -- Senior citizen concession.
    --
    -- Age 60 or above:
    --     40% concession
    --
    -- Otherwise:
    --     No concession
    --
    -- CASE is used to keep the concession logic clear.
    -- --------------------------------------------------------

    v_discount :=
        CASE
            WHEN v_age >= 60 THEN
                v_base_fare * 0.40
            ELSE
                0
        END;


    -- --------------------------------------------------------
    -- Calculate final fare.
    -- --------------------------------------------------------

    v_final_fare :=
        v_base_fare - v_discount;


    -- --------------------------------------------------------
    -- Set passenger status for the ticket.
    -- --------------------------------------------------------

    v_status :=
        CASE
            WHEN v_age >= 60 THEN
                'Senior Citizen'
            ELSE
                'Regular Passenger'
        END;


    -- ========================================================
    -- PRINT TICKET
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('              INDIAN RAILWAYS', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('             PASSENGER TICKET', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Passenger Name', 22) ||
        ':' ||
        LPAD(v_name, 25) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('PNR', 22) ||
        ':' ||
        LPAD(v_pnr, 25) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Roll Number', 22) ||
        ':' ||
        LPAD(v_roll, 25) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Date of Birth', 22) ||
        ':' ||
        LPAD(
            TO_CHAR(v_dob, 'DD-MON-YYYY'),
            25
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Age', 22) ||
        ':' ||
        LPAD(v_age || ' years', 25) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Passenger Type', 22) ||
        ':' ||
        LPAD(v_status, 25) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Journey Date', 22) ||
        ':' ||
        LPAD(
            TO_CHAR(
                v_journey_date,
                'Day, DD-MON-YYYY'
            ),
            25
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Base Fare', 22) ||
        ':' ||
        LPAD(
            'Rs.' ||
            TO_CHAR(v_base_fare, 'FM99,999.00'),
            25
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Concession', 22) ||
        ':' ||
        LPAD(
            'Rs.' ||
            TO_CHAR(v_discount, 'FM99,999.00'),
            25
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Final Fare', 22) ||
        ':' ||
        LPAD(
            'Rs.' ||
            TO_CHAR(v_final_fare, 'FM99,999.00'),
            25
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

END;
/