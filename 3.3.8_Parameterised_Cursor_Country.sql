SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.8 - PARAMETERISED CURSOR - COUNTRY
--
-- Question:
-- Write a parameterised cursor that accepts a country and
-- displays all publishers from that country.
--
-- If the parameter matches no publisher, display:
--
--     No publisher found in <country>
--
-- Use a BOOLEAN flag.
--
-- Also explain why %ROWCOUNT cannot be checked after a
-- cursor FOR LOOP has ended.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts country as a parameter.
-- 2. UPPER() is used for case-insensitive comparison.
-- 3. A BOOLEAN flag is used to check whether a row was found.
-- 4. A cursor FOR LOOP automatically opens and closes the
--    cursor. After the FOR LOOP ends, the cursor is closed,
--    so checking its %ROWCOUNT at that point can raise
--    ORA-01001.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    -- ========================================================

    CURSOR c_publisher (
        p_country VARCHAR2
    ) IS
        SELECT pub_id,
               pub_name,
               city,
               country
        FROM publisher
        WHERE UPPER(country) = UPPER(p_country)
        ORDER BY pub_id;


    -- ========================================================
    -- BOOLEAN flag
    --
    -- FALSE means no publisher has been found yet.
    -- TRUE means at least one publisher was found.
    -- ========================================================

    v_found BOOLEAN := FALSE;


BEGIN

    -- ========================================================
    -- Display the country entered by the user.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Country : ' || '&country'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Process publishers from the selected country.
    -- ========================================================

    FOR r_publisher IN c_publisher('&country')
    LOOP

        -- A matching publisher has been found.

        v_found := TRUE;


        DBMS_OUTPUT.PUT_LINE(
            'Publisher ID : ' || r_publisher.pub_id
        );

        DBMS_OUTPUT.PUT_LINE(
            'Publisher    : ' || r_publisher.pub_name
        );

        DBMS_OUTPUT.PUT_LINE(
            'City         : ' || r_publisher.city
        );

        DBMS_OUTPUT.PUT_LINE(
            'Country      : ' || r_publisher.country
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


    -- ========================================================
    -- If no publisher was found, display the required message.
    -- ========================================================

    IF NOT v_found THEN

        DBMS_OUTPUT.PUT_LINE(
            'No publisher found in ' || '&country'
        );

    END IF;


    -- ========================================================
    -- NOTE:
    --
    -- We do NOT use c_publisher%ROWCOUNT here.
    --
    -- A cursor FOR LOOP automatically opens the cursor before
    -- the loop and closes it after the loop finishes.
    -- Therefore the cursor is closed when execution reaches
    -- this point, and checking %ROWCOUNT after the loop can
    -- raise ORA-01001 (invalid cursor).
    -- ========================================================


END;
/
