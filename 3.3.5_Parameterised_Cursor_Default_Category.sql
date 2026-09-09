SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.5 - PARAMETERISED CURSOR WITH DEFAULT VALUE
--
-- Question:
-- Declare a parameterised cursor with a DEFAULT value for
-- its parameter.
--
-- Example:
-- CURSOR c (p_cat VARCHAR2 DEFAULT 'Database')
--
-- Open the cursor:
-- 1. Once without an argument.
-- 2. Once with the argument 'Networking'.
--
-- Display both outputs.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. A cursor parameter can have a DEFAULT value.
-- 2. When no argument is supplied, the DEFAULT value is used.
-- 3. When an argument is supplied, it replaces the DEFAULT.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor with DEFAULT value.
    --
    -- If no category is supplied, 'Database' is used.
    -- ========================================================

    CURSOR c_book (
        p_cat VARCHAR2 DEFAULT 'Database'
    ) IS
        SELECT book_id,
               title,
               price,
               category
        FROM book
        WHERE UPPER(category) = UPPER(p_cat)
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- TEST 1
    --
    -- Open cursor without supplying an argument.
    -- Therefore the DEFAULT category 'Database' is used.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'TEST 1 - DEFAULT CATEGORY'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Category : Database'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_book IN c_book
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


    -- ========================================================
    -- TEST 2
    --
    -- Open cursor with the argument 'Networking'.
    -- The supplied value replaces the DEFAULT value.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        ' '
    );

    DBMS_OUTPUT.PUT_LINE(
        'TEST 2 - EXPLICIT CATEGORY'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Category : Networking'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_book IN c_book('Networking')
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


END;
/