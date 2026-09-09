SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.4 - CURSOR %ROWCOUNT - RUNNING SERIAL NUMBER
--
-- Question:
-- List all books whose price is greater than 500.
-- Print a running serial number before each row using
-- the %ROWCOUNT attribute.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor selects only books with price greater than 500.
-- 2. %ROWCOUNT gives the number of rows fetched so far.
-- 3. In a cursor FOR LOOP, %ROWCOUNT increases for every
--    successfully fetched row.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, price
        FROM book
        WHERE price > 500
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- Cursor FOR LOOP
    -- ========================================================

    FOR r_book IN c_book
    LOOP

        -- ----------------------------------------------------
        -- %ROWCOUNT gives the running serial number.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            c_book%ROWCOUNT
            || '. '
            || r_book.title
            || ' - Rs.'
            || r_book.price
        );

    END LOOP;


END;
/