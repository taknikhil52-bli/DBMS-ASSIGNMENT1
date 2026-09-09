SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.3 - CURSOR %ROWTYPE
--
-- Question:
-- Use %ROWTYPE with the cursor to display all columns of
-- the BOOK table for each book.
--
-- Student Name : Nirav Vala
-- Roll No      : 33
--
-- Key points:
-- 1. %ROWTYPE creates a record based on the cursor row.
-- 2. The cursor FOR LOOP automatically fetches each row.
-- 3. The record variable can be used to access all selected
--    columns using dot notation.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor selecting all columns from BOOK.
    -- ========================================================

    CURSOR c_book IS
        SELECT *
        FROM book
        ORDER BY book_id;


    -- ========================================================
    -- %ROWTYPE record
    --
    -- This record has the same structure as one row returned
    -- by cursor c_book.
    -- ========================================================

    v_book c_book%ROWTYPE;


BEGIN

    -- ========================================================
    -- Fetch each complete BOOK row using the cursor FOR LOOP.
    -- ========================================================

    FOR v_book IN c_book
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID   : ' || v_book.book_id
        );

        DBMS_OUTPUT.PUT_LINE(
            'Title     : ' || v_book.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Category  : ' || v_book.category
        );

        DBMS_OUTPUT.PUT_LINE(
            'Price     : Rs.' || v_book.price
        );

        DBMS_OUTPUT.PUT_LINE(
            'Stock     : ' || v_book.stock
        );

        DBMS_OUTPUT.PUT_LINE(
            'Publisher : ' || v_book.pub_id
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


END;
/