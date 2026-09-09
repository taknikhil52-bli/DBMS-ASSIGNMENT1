    SET SERVEROUTPUT ON;

    -- ============================================================
    -- P1.13 - ATM Note Splitter
    --
    -- Question:
    -- An ATM must dispense a withdrawal amount using the minimum
    -- number of notes of:
    --     Rs.500
    --     Rs.200
    --     Rs.100
    --
    -- Calculate:
    -- 1. Number of Rs.500 notes
    -- 2. Number of Rs.200 notes
    -- 3. Number of Rs.100 notes
    -- 4. Remaining amount that cannot be dispensed
    --
    -- Required logic:
    --     n500 = TRUNC(amount / 500)
    --     rem  = MOD(amount, 500)
    --     n200 = TRUNC(rem / 200)
    --     rem  = MOD(rem, 200)
    --     n100 = TRUNC(rem / 100)
    --     rem  = MOD(rem, 100)
    --
    -- Key points:
    -- 1. TRUNC() is used to get the whole number of notes.
    -- 2. MOD() gives the remaining amount after a denomination
    --    is used.
    -- 3. The largest denomination is processed first.
    -- 4. The final remainder is the amount below Rs.100 that
    --    cannot be dispensed using the available denominations.
    --
    -- Personalised details:
    -- Name    : Nikhil tak
    -- Roll No : 50
    --
    -- Assignment formula:
    -- amount = roll_no * 137 + 1000
    --
    -- amount = 50 * 137 + 1000
    --        = 5521
    -- ============================================================

    DECLARE
        v_amount NUMBER;

        v_n500 NUMBER;
        v_n200 NUMBER;
        v_n100 NUMBER;

        v_remainder NUMBER;
    BEGIN

        -- --------------------------------------------------------
        -- Generate withdrawal amount using the assignment formula.
        -- --------------------------------------------------------

        v_amount := 50 * 137 + 1000;


        -- --------------------------------------------------------
        -- Calculate Rs.500 notes.
        -- --------------------------------------------------------

        v_n500 := TRUNC(v_amount / 500);

        -- Find the amount remaining after Rs.500 notes.
        v_remainder := MOD(v_amount, 500);


        -- --------------------------------------------------------
        -- Calculate Rs.200 notes from the remaining amount.
        -- --------------------------------------------------------

        v_n200 := TRUNC(v_remainder / 200);

        -- Find the amount remaining after Rs.200 notes.
        v_remainder := MOD(v_remainder, 200);


        -- --------------------------------------------------------
        -- Calculate Rs.100 notes from the remaining amount.
        -- --------------------------------------------------------

        v_n100 := TRUNC(v_remainder / 100);

        -- Final amount below Rs.100 cannot be dispensed.
        v_remainder := MOD(v_remainder, 100);


        -- --------------------------------------------------------
        -- Display the ATM note breakup.
        -- --------------------------------------------------------

        DBMS_OUTPUT.PUT_LINE('========================================');
        DBMS_OUTPUT.PUT_LINE('           ATM NOTE SPLITTER');
        DBMS_OUTPUT.PUT_LINE('========================================');

        DBMS_OUTPUT.PUT_LINE(
            'Name           : Nikhil tak'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Roll No        : 50'
        );

        DBMS_OUTPUT.PUT_LINE(
            'Withdrawal Amt : Rs.' || v_amount
        );

        DBMS_OUTPUT.PUT_LINE('----------------------------------------');

        DBMS_OUTPUT.PUT_LINE(
            'Rs.500 Notes   : ' || v_n500
        );

        DBMS_OUTPUT.PUT_LINE(
            'Rs.200 Notes   : ' || v_n200
        );

        DBMS_OUTPUT.PUT_LINE(
            'Rs.100 Notes   : ' || v_n100
        );

        DBMS_OUTPUT.PUT_LINE(
            'Undispensed    : Rs.' || v_remainder
        );

        DBMS_OUTPUT.PUT_LINE('========================================');

    END;
    /