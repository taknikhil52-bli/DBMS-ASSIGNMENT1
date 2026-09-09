SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.6 - ZOMATO DELIVERY PRICE ENGINE
--
-- Question:
-- Build a Zomato-style delivery charge calculator.
--
-- Base delivery charge:
--     Distance < 3 km       -> Free
--     Distance 3-8 km      -> Rs.29
--     Distance 8-15 km     -> Rs.49
--     Distance > 15 km     -> Rs.79
--
-- Surcharges using CASE:
--     Rain                    -> +20%
--     Late Night (10PM-6AM)  -> +15%
--     Festival Day            -> +10%
--     Peak Hour               -> +10%
--                                (12-2PM or 7-9PM)
--
-- Discounts using IF:
--     Order value > Rs.499 -> Delivery becomes FREE
--                            and overrides everything.
--
--     First Order          -> 50% off delivery
--
-- Print:
--     Base delivery
--     Each surcharge
--     Discount
--     Final delivery charge
--     Food total
--     Grand total
--
-- Round all final amounts to nearest rupee.
--
-- Key points:
-- 1. CASE is used to calculate each surcharge.
-- 2. IF is used for discount/override logic.
-- 3. Boolean flags represent conditions such as rain,
--    festival and first-order status.
-- 4. Order value > Rs.499 has highest priority.
-- 5. First-order discount is applied only when the
--    free-delivery condition is not active.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- NOTE:
-- P2.6 does not specify a roll-number input formula.
-- Therefore the worked-example values from the assignment
-- are used for this execution.
--
-- Test data:
--     Food Total = Rs.350
--     Distance   = 5 km
--     Rain       = YES
--     Late Night = NO
--     Festival   = NO
--     Peak Hour  = NO
--     First Order= NO
--
-- Expected:
--     Base delivery = Rs.29
--     Rain surcharge = 20% of Rs.29 = Rs.5.80
--     Final delivery = ROUND(34.80) = Rs.35
--     Grand total = Rs.385
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- Order details
    -- --------------------------------------------------------

    v_food_total NUMBER := 350;
    v_distance NUMBER := 5;


    -- --------------------------------------------------------
    -- Boolean flags
    --
    -- TRUE/FALSE values make the surcharge logic easy to read.
    -- --------------------------------------------------------

    v_rain BOOLEAN := TRUE;
    v_late_night BOOLEAN := FALSE;
    v_festival BOOLEAN := FALSE;
    v_peak_hour BOOLEAN := FALSE;
    v_first_order BOOLEAN := FALSE;


    -- --------------------------------------------------------
    -- Delivery calculation variables
    -- --------------------------------------------------------

    v_base_delivery NUMBER := 0;

    v_rain_charge NUMBER := 0;
    v_late_charge NUMBER := 0;
    v_festival_charge NUMBER := 0;
    v_peak_charge NUMBER := 0;

    v_surcharge_total NUMBER := 0;

    v_delivery_before_discount NUMBER := 0;

    v_discount NUMBER := 0;

    v_final_delivery NUMBER := 0;

    v_grand_total NUMBER := 0;

BEGIN

    -- ========================================================
    -- STEP 1: DETERMINE BASE DELIVERY CHARGE
    --
    -- <3 km       -> Free
    -- 3-8 km      -> Rs.29
    -- 8-15 km     -> Rs.49
    -- >15 km      -> Rs.79
    -- ========================================================

    IF v_distance < 3 THEN

        v_base_delivery := 0;

    ELSIF v_distance <= 8 THEN

        v_base_delivery := 29;

    ELSIF v_distance <= 15 THEN

        v_base_delivery := 49;

    ELSE

        v_base_delivery := 79;

    END IF;


    -- ========================================================
    -- STEP 2: CALCULATE SURCHARGES USING CASE
    --
    -- Each surcharge is calculated from the BASE delivery
    -- charge, as required by the assignment.
    -- ========================================================

    v_rain_charge :=
        CASE
            WHEN v_rain THEN
                v_base_delivery * 0.20
            ELSE
                0
        END;


    v_late_charge :=
        CASE
            WHEN v_late_night THEN
                v_base_delivery * 0.15
            ELSE
                0
        END;


    v_festival_charge :=
        CASE
            WHEN v_festival THEN
                v_base_delivery * 0.10
            ELSE
                0
        END;


    v_peak_charge :=
        CASE
            WHEN v_peak_hour THEN
                v_base_delivery * 0.10
            ELSE
                0
        END;


    -- --------------------------------------------------------
    -- Add all applicable surcharges.
    -- --------------------------------------------------------

    v_surcharge_total :=
        v_rain_charge
        + v_late_charge
        + v_festival_charge
        + v_peak_charge;


    -- ========================================================
    -- STEP 3: DELIVERY BEFORE DISCOUNT
    -- ========================================================

    v_delivery_before_discount :=
        v_base_delivery + v_surcharge_total;


    -- ========================================================
    -- STEP 4: DISCOUNT LOGIC USING IF
    --
    -- Condition 1:
    -- Food order > Rs.499
    --     -> Delivery FREE
    --     -> Overrides every surcharge/discount.
    --
    -- Condition 2:
    -- First order
    --     -> 50% off delivery.
    --
    -- Condition 3:
    -- Otherwise no discount.
    -- ========================================================

    IF v_food_total > 499 THEN

        v_discount := v_delivery_before_discount;

        v_final_delivery := 0;


    ELSIF v_first_order THEN

        v_discount :=
            v_delivery_before_discount * 0.50;

        v_final_delivery :=
            v_delivery_before_discount - v_discount;


    ELSE

        v_discount := 0;

        v_final_delivery :=
            v_delivery_before_discount;

    END IF;


    -- ========================================================
    -- STEP 5: ROUND FINAL DELIVERY CHARGE
    -- ========================================================

    v_final_delivery :=
        ROUND(v_final_delivery);


    -- ========================================================
    -- STEP 6: GRAND TOTAL
    -- ========================================================

    v_grand_total :=
        ROUND(
            v_food_total + v_final_delivery
        );


    -- ========================================================
    -- OUTPUT
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('           ZOMATO DELIVERY RECEIPT', 48) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Customer', 24) ||
        ': ' ||
        RPAD(v_name, 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Roll No', 24) ||
        ': ' ||
        RPAD(v_roll, 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Food Total', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_food_total, 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Distance', 24) ||
        ': ' ||
        RPAD(v_distance || ' km', 22) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Base Delivery', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_base_delivery, 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Rain Surcharge', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_rain_charge), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Late Night Surcharge', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_late_charge), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Festival Surcharge', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_festival_charge), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Peak Hour Surcharge', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_peak_charge), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Total Surcharges', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_surcharge_total), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Discount', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(ROUND(v_discount), 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Final Delivery', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_final_delivery, 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('Food Total', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_food_total, 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '|' ||
        RPAD('GRAND TOTAL', 24) ||
        ': Rs.' ||
        LPAD(
            TO_CHAR(v_grand_total, 'FM99,999'),
            18
        ) ||
        '|'
    );

    DBMS_OUTPUT.PUT_LINE(
        '+------------------------------------------------+'
    );

END;
/