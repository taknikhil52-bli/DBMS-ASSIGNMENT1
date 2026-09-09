SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.7 - NESTED SIMPLE AND PARAMETERISED CURSORS
--
-- Question:
-- Write a block containing two cursors:
--
-- 1. A simple cursor over PUBLISHER.
-- 2. A parameterised cursor that accepts a pub_id.
--
-- Loop over the publishers and, for each publisher, open
-- the inner cursor to display that publisher's books
-- indented below its name.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The outer cursor processes all publishers.
-- 2. The inner cursor accepts the current publisher's pub_id.
-- 3. The inner cursor is executed once for each publisher.
-- 4. Publisher books are displayed below the publisher name.
-- ============================================================


DECLARE

    -- ========================================================
    -- OUTER CURSOR
    --
    -- Simple cursor over the PUBLISHER table.
    -- ========================================================

    CURSOR c_publisher IS
        SELECT pub_id,
               pub_name,
               city,
               country
        FROM publisher
        ORDER BY pub_id;


    -- ========================================================
    -- INNER CURSOR
    --
    -- Parameterised cursor accepting publisher ID.
    -- ========================================================

    CURSOR c_book (
        p_pub_id NUMBER
    ) IS
        SELECT book_id,
               title,
               price
        FROM book
        WHERE pub_id = p_pub_id
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- OUTER LOOP
    --
    -- Process every publisher.
    -- ========================================================

    FOR r_publisher IN c_publisher
    LOOP

        -- ----------------------------------------------------
        -- Display publisher information.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            r_publisher.pub_name
            || ' (' || r_publisher.country || ')'
        );


        -- ----------------------------------------------------
        -- INNER LOOP
        --
        -- Pass the current publisher's ID to the
        -- parameterised cursor.
        -- ----------------------------------------------------

        FOR r_book IN c_book(r_publisher.pub_id)
        LOOP

            -- Two spaces are used to indent the book details
            -- below the publisher name.

            DBMS_OUTPUT.PUT_LINE(
                '  -> '
                || r_book.title
                || ' - Rs.'
                || r_book.price
            );

        END LOOP;


        -- ----------------------------------------------------
        -- Blank line between publishers.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(' ');

    END LOOP;


END;
/