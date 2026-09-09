SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.1 - PARAMETERISED CURSOR - CATEGORY
--
-- Question:
-- Write a parameterised cursor that accepts a category
-- and displays all books of that category.
--
-- Accept the category from the user using a substitution
-- variable and test it with:
--
-- 1. Database
-- 2. Programming
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. A parameterised cursor accepts a value when it is opened.
-- 2. The cursor parameter is declared in the cursor header.
-- 3. Do not specify a size for the cursor parameter.
-- 4. &category is a SQL*Plus substitution variable.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- p_category receives the category supplied by the user.
    -- ========================================================

    CURSOR c_book (p_category VARCHAR2) IS
        SELECT book_id, title, price, stock
        FROM book
        WHERE UPPER(category) = UPPER(p_category)
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- Open the parameterised cursor using the user's input.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Books in category: ' || '&category'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_book IN c_book('&category')
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
            || ' | Stock : ' || r_book.stock
        );

    END LOOP;


END;
/