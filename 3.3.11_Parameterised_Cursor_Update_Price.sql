SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.11 - PARAMETERISED CURSOR - UPDATE PRICE
--
-- Question:
-- Write a parameterised cursor with FOR UPDATE that accepts
-- a category and increases the price of all books in that
-- category by 10 percent using WHERE CURRENT OF.
--
-- Display:
-- 1. Book title
-- 2. Old price
-- 3. New price
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts category as a parameter.
-- 2. FOR UPDATE locks the selected rows for modification.
-- 3. WHERE CURRENT OF updates the current cursor row.
-- 4. New price = old price + 10% of old price.
-- 5. COMMIT saves the changes permanently.
--
-- IMPORTANT:
-- This program changes BOOK prices. Run it only once for
-- the selected category.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor with FOR UPDATE.
    --
    -- The cursor selects books belonging to the category
    -- supplied when the cursor is used.
    -- ========================================================

    CURSOR c_book (
        p_category VARCHAR2
    ) IS
        SELECT book_id,
               title,
               price
        FROM book
        WHERE UPPER(category) = UPPER(p_category)
        FOR UPDATE;


    -- ========================================================
    -- Variables for old and new prices.
    -- ========================================================

    v_old_price book.price%TYPE;
    v_new_price book.price%TYPE;


BEGIN

    -- ========================================================
    -- Test category:
    -- Database
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Category : Database'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Price Increase : 10%'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Process each Database category book.
    -- ========================================================

    FOR r_book IN c_book('Database')
    LOOP

        -- ----------------------------------------------------
        -- Store the old price.
        -- ----------------------------------------------------

        v_old_price := r_book.price;


        -- ----------------------------------------------------
        -- Calculate the new price.
        -- ----------------------------------------------------

        v_new_price :=
            ROUND(v_old_price * 1.10, 2);


        -- ----------------------------------------------------
        -- Update the current row.
        --
        -- WHERE CURRENT OF refers to the row currently
        -- fetched by cursor c_book.
        -- ----------------------------------------------------

        UPDATE book
        SET price = v_new_price
        WHERE CURRENT OF c_book;


        -- ----------------------------------------------------
        -- Display old and new prices.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Title     : ' || r_book.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Old Price : Rs.' || v_old_price
        );

        DBMS_OUTPUT.PUT_LINE(
            'New Price : Rs.' || v_new_price
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


    -- ========================================================
    -- Save the updated prices.
    -- ========================================================

    COMMIT;


    DBMS_OUTPUT.PUT_LINE(
        'Price updated successfully.'
    );


END;
/