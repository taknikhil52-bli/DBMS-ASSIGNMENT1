SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.2 - CURSOR FOR LOOP
--
-- Question:
-- Rewrite the previous program using a cursor FOR LOOP.
-- Display book_id, title and price of every book.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key point:
-- The cursor FOR LOOP automatically performs OPEN, FETCH,
-- EXIT WHEN %NOTFOUND and CLOSE operations for us.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    --
    -- The cursor selects all books from the BOOK table.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, price
        FROM book
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- Cursor FOR LOOP
    --
    -- Oracle automatically:
    -- 1. Opens the cursor
    -- 2. Fetches each row
    -- 3. Stops when there are no more rows
    -- 4. Closes the cursor
    -- ========================================================

    FOR r_book IN c_book
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


END;
/
