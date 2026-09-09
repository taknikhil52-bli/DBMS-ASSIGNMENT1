SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.11 - TOP 5 EXPENSIVE BOOKS
--
-- Question:
-- Display the top 5 most expensive books.
--
-- Use %ROWCOUNT to stop after 5 rows.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. Sort books by price in descending order.
-- 2. Use an explicit cursor.
-- 3. Use %ROWCOUNT to count fetched rows.
-- 4. Stop the loop after 5 books.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor to fetch books from highest price to lowest price.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, price
        FROM book
        ORDER BY price DESC;


BEGIN

    -- ========================================================
    -- Process books using the cursor.
    -- ========================================================

    FOR r_book IN c_book
    LOOP

        -- ----------------------------------------------------
        -- Stop after displaying the first 5 books.
        -- ----------------------------------------------------

        EXIT WHEN c_book%ROWCOUNT > 5;


        -- ----------------------------------------------------
        -- Display book information.
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