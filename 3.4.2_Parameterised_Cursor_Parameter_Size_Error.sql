SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.2 - PARAMETERISED CURSOR PARAMETER SIZE ERROR
--
-- Question:
-- The following cursor declaration causes a compilation error:
--
--     CURSOR c_book(p_cat VARCHAR2(20)) IS
--
-- Identify the error and rewrite the declaration correctly.
--
-- Student Name : Nirav Vala
-- Roll No      : 33
--
-- Key point:
-- A parameter of a parameterised cursor must not specify
-- a size or precision.
--
-- WRONG:
--     p_cat VARCHAR2(20)
--
-- CORRECT:
--     p_cat VARCHAR2
-- ============================================================


DECLARE

    -- ========================================================
    -- CORRECT CURSOR DECLARATION
    --
    -- Do not specify VARCHAR2(20).
    -- ========================================================

    CURSOR c_book (
        p_cat VARCHAR2
    ) IS
        SELECT book_id,
               title,
               price
        FROM book
        WHERE UPPER(category) = UPPER(p_cat)
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- Test the corrected cursor.
    -- ========================================================

    FOR r_book IN c_book('Database')
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book ID : ' || r_book.book_id
            || ' | Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


END;
/