SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.10 - LOW STOCK REORDER COUNTER
--
-- Question:
-- Display the details of books whose stock is less than 5
-- and print the word REORDER against each.
--
-- Count how many such books exist and display the count
-- after the loop.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. Use a cursor on the BOOK table.
-- 2. Filter books where stock < 5.
-- 3. Display REORDER for every matching book.
-- 4. Maintain a counter inside the loop.
-- 5. Display the final count after the loop.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor for books having stock less than 5.
    -- ========================================================

    CURSOR c_low_stock IS
        SELECT book_id, title, stock
        FROM book
        WHERE stock < 5
        ORDER BY book_id;


    -- ========================================================
    -- Variable to count low-stock books.
    -- ========================================================

    v_count NUMBER := 0;


BEGIN

    -- ========================================================
    -- Process each low-stock book.
    -- ========================================================

    FOR r_book IN c_low_stock
    LOOP

        -- ----------------------------------------------------
        -- Increase the counter for every matching book.
        -- ----------------------------------------------------

        v_count := v_count + 1;


        -- ----------------------------------------------------
        -- Display book details and REORDER message.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Stock : ' || r_book.stock
            || ' | REORDER'
        );

    END LOOP;


    -- ========================================================
    -- Display total number of low-stock books.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Total books requiring REORDER : ' || v_count
    );


END;
/