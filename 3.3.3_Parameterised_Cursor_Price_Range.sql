SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.3 - PARAMETERISED CURSOR - PRICE RANGE
--
-- Question:
-- Write a cursor that takes two parameters, a minimum and a
-- maximum price, and displays all books whose price falls
-- in that range.
--
-- Test it with:
-- Minimum Price = 300
-- Maximum Price = 700
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts two parameters.
-- 2. The parameters are used in the WHERE condition.
-- 3. BETWEEN includes both the minimum and maximum values.
-- 4. No size is specified for cursor parameters.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- p_min_price = minimum allowed price
    -- p_max_price = maximum allowed price
    -- ========================================================

    CURSOR c_book (
        p_min_price NUMBER,
        p_max_price NUMBER
    ) IS
        SELECT book_id, title, price
        FROM book
        WHERE price BETWEEN p_min_price AND p_max_price
        ORDER BY price;


BEGIN

    -- ========================================================
    -- Display the selected price range.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Books with price between Rs.300 and Rs.700'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Open the parameterised cursor with:
    -- Minimum Price = 300
    -- Maximum Price = 700
    -- ========================================================

    FOR r_book IN c_book(300, 700)
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


END;
/