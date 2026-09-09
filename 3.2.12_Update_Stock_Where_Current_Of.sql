SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.12 - UPDATE STOCK USING WHERE CURRENT OF
--
-- Question:
-- Write a block using SELECT ... FOR UPDATE and
-- WHERE CURRENT OF that increases the stock of every
-- book in the 'Database' category by 10.
--
-- Display:
-- 1. Book title
-- 2. Old stock
-- 3. New stock
--
-- Remember to COMMIT.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. FOR UPDATE locks the selected rows for modification.
-- 2. WHERE CURRENT OF updates the row currently fetched
--    by the cursor.
-- 3. The old stock is saved before performing the update.
-- 4. New stock is increased by 10.
-- 5. COMMIT permanently saves the changes.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor selects Database category books.
    --
    -- FOR UPDATE locks the selected rows so that they can
    -- safely be updated using WHERE CURRENT OF.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title, stock
        FROM book
        WHERE category = 'Database'
        FOR UPDATE;


    -- ========================================================
    -- Variable to store the old stock value.
    -- ========================================================

    v_old_stock book.stock%TYPE;

    v_new_stock book.stock%TYPE;


BEGIN

    -- ========================================================
    -- Fetch and update each Database category book.
    -- ========================================================

    FOR r_book IN c_book
    LOOP

        -- ----------------------------------------------------
        -- Store the old stock before updating.
        -- ----------------------------------------------------

        v_old_stock := r_book.stock;


        -- ----------------------------------------------------
        -- Increase stock by 10.
        --
        -- WHERE CURRENT OF updates the row currently pointed
        -- to by cursor c_book.
        -- ----------------------------------------------------

        UPDATE book
        SET stock = stock + 10
        WHERE CURRENT OF c_book;


        -- ----------------------------------------------------
        -- Calculate the new stock for display.
        -- ----------------------------------------------------

        v_new_stock := v_old_stock + 10;


        -- ----------------------------------------------------
        -- Display old and new stock.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Book : ' || r_book.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Old Stock : ' || v_old_stock
            || ' | New Stock : ' || v_new_stock
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


    -- ========================================================
    -- Save all changes.
    -- ========================================================

    COMMIT;


    DBMS_OUTPUT.PUT_LINE(
        'Stock updated successfully.'
    );


END;
/