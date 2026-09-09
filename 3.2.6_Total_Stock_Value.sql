SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.6 - TOTAL STOCK VALUE
--
-- Question:
-- Fetch all books and calculate the total stock value
-- (price * stock) by accumulating inside the loop.
--
-- Display:
-- 1. Each book's individual stock value
-- 2. Grand total after the loop ends
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. Use a simple explicit cursor.
-- 2. Calculate individual value as price * stock.
-- 3. Add each individual value to a running total.
-- 4. Display the grand total after the loop.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor to fetch all books.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, price, stock
        FROM book
        ORDER BY book_id;


    -- ========================================================
    -- Variable to store the running grand total.
    -- ========================================================

    v_total_value NUMBER := 0;

    v_book_value NUMBER;


BEGIN

    -- ========================================================
    -- Process each book using cursor FOR LOOP.
    -- ========================================================

    FOR r_book IN c_book
    LOOP

        -- ----------------------------------------------------
        -- Calculate individual stock value.
        --
        -- Stock Value = Price × Stock
        -- ----------------------------------------------------

        v_book_value :=
            r_book.price * r_book.stock;


        -- ----------------------------------------------------
        -- Add the current book value to the grand total.
        -- ----------------------------------------------------

        v_total_value :=
            v_total_value + v_book_value;


        -- ----------------------------------------------------
        -- Display individual book value.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | '
            || r_book.title
            || ' | Stock Value : Rs.'
            || v_book_value
        );

    END LOOP;


    -- ========================================================
    -- Display grand total after the loop.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Grand Total Stock Value : Rs.'
        || v_total_value
    );


END;
/