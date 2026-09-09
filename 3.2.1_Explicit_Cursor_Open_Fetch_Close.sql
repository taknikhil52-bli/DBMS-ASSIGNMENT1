SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.1 - EXPLICIT CURSOR: OPEN, FETCH AND CLOSE
--
-- Question:
-- Declare a cursor on the BOOK table and display book_id,
-- title and price of every book.
--
-- Use:
-- 1. Explicit cursor
-- 2. OPEN
-- 3. FETCH
-- 4. Simple LOOP
-- 5. %NOTFOUND
-- 6. CLOSE
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. A cursor is used to process multiple rows.
-- 2. OPEN executes the cursor query.
-- 3. FETCH gets one row at a time.
-- 4. %NOTFOUND becomes TRUE when no row is fetched.
-- 5. CLOSE releases the cursor.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    --
    -- The cursor selects all books with the required columns.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, price
        FROM book
        ORDER BY book_id;


    -- ========================================================
    -- Variables to store one fetched row
    -- ========================================================

    v_book_id book.book_id%TYPE;

    v_title book.title%TYPE;

    v_price book.price%TYPE;


BEGIN

    -- ========================================================
    -- OPEN CURSOR
    -- ========================================================

    OPEN c_book;


    -- ========================================================
    -- FETCH rows one by one
    -- ========================================================

    LOOP

        FETCH c_book
        INTO v_book_id, v_title, v_price;


        -- ----------------------------------------------------
        -- When FETCH does not find another row,
        -- %NOTFOUND becomes TRUE and the loop stops.
        -- ----------------------------------------------------

        EXIT WHEN c_book%NOTFOUND;


        -- ----------------------------------------------------
        -- Display the current book.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || v_book_id
            || ' | Title : ' || v_title
            || ' | Price : Rs.' || v_price
        );

    END LOOP;


    -- ========================================================
    -- CLOSE CURSOR
    -- ========================================================

    CLOSE c_book;


END;
/